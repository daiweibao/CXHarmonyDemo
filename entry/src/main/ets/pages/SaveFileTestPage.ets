import picker from '@ohos.file.picker';//导入选择器模块和文件管理模块
import fs from '@ohos.file.fs';//通过沙箱路径获取图片的文件描述符，导入@ohos.file.fs模块

@Entry
@Component
struct SaveFileTestPage {
  private  URI = null;

  //打开文件应用，创建保存文件的路径
  createSaveImagePath(){
    // 创建文件管理器保存选项实例
    const photoSaveOptions = new picker.PhotoSaveOptions();
    // 保存文件名（可选）
    photoSaveOptions.newFileNames = ["PhotoViewPicker01.jpg"];
    // let URI = null;
    //创建图库选择器实例，调用save()接口拉起FilePicker界面进行文件保存。
    //用户选择目标文件夹，用户选择与文件类型相对应的文件夹，即可完成文件保存操作。保存成功后，返回保存文档的URI。
    const photoViewPicker = new picker.PhotoViewPicker();
    photoViewPicker.save(photoSaveOptions).then((photoSaveResult) => {//好像【模拟器】不能打开
      //save返回的URI权限是【读写权限】，可以根据结果集中URI进行文件读写等操作。
      //注意不能在picker的回调里直接使用此URI进行打开文件操作，需要定义一个全局变量保存URI，使用类似一个按钮去触发打开文件。
      this.URI = photoSaveResult[0];//要保存的文件路径
      console.info('图片保存成功URI is:' + this.URI);
    }).catch((err) => {
      console.error(`图片保存失败, code is ${err.code}, message is ${err.message}`);
    })
  }

  //往URL路径里保存文件
  async saveImageFile(){
    // 获取上下文
    const context = getContext(this)
    // 获取resourceManager资源管理
    const resourceMgr = context.resourceManager
    // 获取media文件夹下的watchGT4.png图片
    const fileData = await resourceMgr.getMediaContent($r('app.media.watchGT4'))
    // 获取图片的ArrayBuffer
    const buffer = fileData.buffer

    //fs.openSync：以同步方法打开文件。支持使用URI打开文件。
    let file = fs.openSync(this.URI, fs.OpenMode.READ_WRITE);//READ_WRITE：读写权限
    console.info('文件fd: ' + file.fd);
    //通过fd使用fs.writeSync接口对这个文件进行编辑修改，编辑修改完成后关闭fd。
    //fs.writeSync以同步方法将数据写入文件。
    // let writeLen = fs.writeSync(file.fd, '我是写入的一段字符串');//字符串案例
    let writeLen = fs.writeSync(file.fd, buffer);//writeSync写入文件。fd：已打开的文件描述符；buffer：待写入文件的数据，可来自缓冲区或字符串。
    console.info('文件写入成功：size is:' + writeLen);
    fs.closeSync(file);
  }

  build() {
    Row() {
      Column() {
        Button('创建保存文件').onClick((event: ClickEvent) => {
          this.createSaveImagePath()
        })
        Button('开始往路径里保存文件').onClick((event: ClickEvent) => {
          this.saveImageFile()
        })

      }
      .width('100%')
    }
    .height('100%')
  }
}
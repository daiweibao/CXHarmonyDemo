import picker from '@ohos.file.picker';//导入选择器模块和文件管理模块。


import fs from '@ohos.file.fs';//通过沙箱路径获取图片的文件描述符，导入@ohos.file.fs模块
import image from '@ohos.multimedia.image';//导入Image模块，图片解码

@Entry
@Component
struct Index {
  //存放从相册选取的照片
  @State imgDatas: string[] = [];
  //图片
  @State pixelMapImage: PixelMap = undefined

  // 获取照片url集
  getAllImg() {
    //创建图库选择选项实例。
    let  PhotoSelectOptions = new picker.PhotoSelectOptions();
    //过滤选择媒体文件类型为图片：IMAGE
    PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.VIDEO_TYPE;
    //选择媒体文件的最大数目
    PhotoSelectOptions.maxSelectNumber = 5;
    //创建图库选择器实例
    let photoPicker = new picker.PhotoViewPicker();
    //调用select()接口拉起FilePicker界面进行文件选择
    photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
      //select返回的URI权限是只读权限，可以根据结果集中URI进行读取文件数据操作。
      // 注意不能在picker的回调里直接使用此URI进行打开文件操作，需要定义一个全局变量保存URI，使用类似一个按钮去触发打开文件。
      this.imgDatas = PhotoSelectResult.photoUris;
      console.log('图库照片选择成功：' + JSON.stringify(PhotoSelectResult));
      //{"photoUris":["datashare:///media/image/397","datashare:///media/image/392"],"isOriginalPhoto":false}
      //数组里存放的：datashare:///media/image/397  可以直接显示到Image组件上
    }).catch((err) => {
      console.error(`照片选择失败. Code: ${err.code}, message: ${err.message}`);
    });
  }

  //aboutToAppear中调用上述函数，获取图库的所有图片url，存在imgDatas中
  async aboutToAppear() {

  }

  //获取手机照片里选择的图片的pixelMap
  async getPhotos_pixelmap(pathURL: string){
    //pathURL是照片选择后PhotoSelectResult.photoUris数组里的图片路径
    const file = fs.openSync(pathURL, fs.OpenMode.READ_ONLY);
    //获取文件描述符fd
    const fd = file.fd;
    //fd为已获得的文件描述符
    const imageSource = image.createImageSource(fd);
    //创建PixelMap
    const pixelMap = await imageSource.createPixelMap();
    return pixelMap
  }

  // 使用imgDatas的url加载图片。
  build() {
    Column() {
      Button('打开相册').onClick((event: ClickEvent) => {
        //打开图库
        this.getAllImg();
      })
      // Button('展示照片').onClick(async (event: ClickEvent) => {
      //   //获取pixelMap格式图片
      //   this.pixelMapImage = await this.getPhotos_pixelmap(this.imgDatas[0])
      // })

      // Image(this.pixelMapImage).width(300).height(300)

      Grid() {
        ForEach(this.imgDatas, item => {
          GridItem() {
            Image(item)
              .width(200)
          }
        }, item => JSON.stringify(item))
      }
      .rowsGap(15)//黄间距
      .columnsGap(15)//列间距
    }.width('100%').height('100%')
  }
}

import image from '@ohos.multimedia.image';//图片处理模块



@Entry
@Component
struct NotificationTest1 {
  //图片
  @State pixelMapImage: PixelMap = undefined

  //得到pixelMap格式图片
  async getRawfile_pixelmap(){
    // 获取上下文
    const context = getContext(this)
    //获取resourceManager资源管理
    const resourceMgr = context.resourceManager
    // 获取rawfile文件夹下的mateX5.png图片
    const fileData = await resourceMgr.getRawFileContent('mateX5.png');
    // 获取图片的ArrayBuffer
    const buffer = fileData.buffer
    // 创建imageSource
    const imageSource = image.createImageSource(buffer)
    // 创建PixelMap
    const pixelMap = await imageSource.createPixelMap()
    return pixelMap;
  }
  //生命周期
  async aboutToAppear(){
    //获取pixelMap格式图片
    this.pixelMapImage = await this.getRawfile_pixelmap()

    //首先得到pixelMap格式的图片：获取图片大小
    this.pixelMapImage.getImageInfo().then( info => {
      console.info('图片宽度：' + info.size.width);
      console.info('图片高度：' + info.size.height);
    }).catch((err) => {
      console.error("失败：" + err);
    });


    //(1)创建图像编码ImagePacker对象。
    const imagePackerApi = image.createImagePacker();
    //(2)设置编码输出流和编码参数：format为图像的编码格式；quality为图像质量，范围从0-100，100为最佳质量。
    let packOpts = { format:"image/jpeg", quality:98 };

    //(3)进行图片编码，并保存编码后的图片。
    //方法一：通过PixelMap进行编码。
    imagePackerApi.packing(this.pixelMapImage, packOpts).then( data => {
      // data 为打包获取到的文件流，写入文件保存即可得到一张图片
      console.log(`图片编码成功：${data}`)
    }).catch(error => {
      console.error('失败: ' + error);
    })

    // //方法二：通过imageSource进行编码。
    // imagePackerApi.packing(imageSource, packOpts).then( data => {
    //   // data 为打包获取到的文件流，写入文件保存即可得到一张图片
    // }).catch(error => {
    //   console.error('Failed to pack the image. And the error is: ' + error);
    // })


  }
  build() {
    Column() {
      Image(this.pixelMapImage ).width(200).height(200)
    }
    .width('100%')
  }
}



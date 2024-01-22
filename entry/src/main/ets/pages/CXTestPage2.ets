
import image from '@ohos.multimedia.image';//全局导入Image模块。

@Entry
@Component
struct CXTestPage2 {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {

        // Image('love.jpg')

        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('222').onClick((event: ClickEvent) => {

          const context = getContext(this);
          // 获取resourceManager资源管理
          const resourceMgr = context.resourceManager;
          resourceMgr.getRawFileContent('chaoxiimage.png').then((fileData)=>{
            // 获取图片的ArrayBuffer
            const buffer = fileData.buffer;
            const imageSource = image.createImageSource(buffer);
            imageSource.createPixelMap().then((pixelMap)=>{
              console.log(`图片${pixelMap}`)
            })
          })

        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
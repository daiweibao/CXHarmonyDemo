
import App from '@system.app'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  build() {
    Row() {
      Column() {
        //本地图片
        Image($r('app.media.chaoxiheader'))
          .width(250)//单位vp，虚拟像素
          .interpolation(ImageInterpolation.High)
        //文本
        Text($r('app.string.width_label'))
          .fontSize(20)
          .fontColor('#ff1876f8')
          .fontWeight(FontWeight.Bold)//字体粗细
      }
      .width('100%')
    }
    .height('100%')
  }
}


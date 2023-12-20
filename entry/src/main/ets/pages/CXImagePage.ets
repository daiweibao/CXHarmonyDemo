import App from '@system.app'
import resourceManager from '@ohos.resourceManager'
@Entry
@Component
struct ImagePage {
  @State imageWidth: number = 150

  build() {
    Column() {
      Row() {
        //本地图片
        Image($r('app.media.chaoxiheader'))
          .width(this.imageWidth) //单位vp，虚拟像素
          .interpolation(ImageInterpolation.High)
      }
      .width('100%')
      .height(400)
      .justifyContent(FlexAlign.Center)

      Row() {
        //文本
        Text($r('app.string.width_label'))
          .fontSize(20)
          .fontColor('#ff1876f8')
          .fontWeight(FontWeight.Bold) //字体粗细
        //输入框
        TextInput({
          placeholder: '请输入图片宽度：',
          text: this.imageWidth.toFixed(0)
        }) //this.imageWidth.toFixed(0)：数字转字符串，0代表小数点保留位数
          .width(150) //宽
          .backgroundColor(Color.White) //背景色
          .type(InputType.Number) //输入框类型
          .onChange((value: string) => {
            //value是用户输入的文本内容
            console.log(value)
            this.imageWidth = parseInt(value) //parseInt(value)：字符串转数字
          })
      }
      .width('90%')
      .padding({ left: 15, right: 15 }) //内边距
      .justifyContent(FlexAlign.SpaceBetween)

      //横向分割线
      Divider()
        .width('91%')

      Row() {
        //按钮
        Button('缩小')
          .width(80)
          .height(30)
          .type(ButtonType.Capsule) //按钮类型
          .onClick(() => {
            //Buton处理点击事件
            if (this.imageWidth >= 10) {
              this.imageWidth -= 10
            }
          })

        Button('放大')
          .width(80)
          .height(30)
          .onClick(() => {
            //Buton处理点击事件
            if (this.imageWidth < 300) {
              this.imageWidth += 10
            }
          })
      }
      .width('100%')
      .margin({ top: 35, left: 10, bottom: 35, right: 10 }) //外边距
      .justifyContent(FlexAlign.SpaceEvenly)

      //Slider
      Slider({
        min: 100, //最小值
        max: 300, //最大值
        value: this.imageWidth, //当前值
        step: 10, //滑动步长，每次滑动走多少距离
        style: SliderStyle.OutSet, //OutSet滑块在外面，InSet滑块在里面
        direction: Axis.Horizontal, //滑动条方向，垂直还是水平
        reverse: false //是否反向滑动
      })
        .width('100%')
        .trackThickness(7) //设置滑块的粗细
        .showTips(true) //是否展示value百分比提示小气泡
        .blockColor('#36d')
        .onChange(valve => {
          //value是当前滑动值
          this.imageWidth = valve
        })
    }
  }
}



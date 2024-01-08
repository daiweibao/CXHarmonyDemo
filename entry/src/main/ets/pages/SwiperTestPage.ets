@Entry
@Component
struct SwiperDemo {
  //监听滚动属性，控制切换页面用
  private swiperController: SwiperController = new SwiperController();

  build() {
    Column({ space: 5 }) {
      Swiper(this.swiperController) {//设置
        Text("0")
          .width(250)
          .height(250)
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)
        Text("1")
          .width(250)
          .height(250)
          .backgroundColor(Color.Green)
          .textAlign(TextAlign.Center)
          .fontSize(30)
        Text("2")
          .width(250)
          .height(250)
          .backgroundColor(Color.Pink)
          .textAlign(TextAlign.Center)
          .fontSize(30)
      }
      .vertical(false)
      .indicator(false)
      .displayCount(2)//设置一个页面内显示两个子组件

      Row({ space: 12 }) {
        Button('展示下一页')
          .onClick(() => {
            this.swiperController.showNext(); // 通过controller切换到后一页
          })
        Button('展示上一页')
          .onClick(() => {
            this.swiperController.showPrevious(); // 通过controller切换到前一页
          })
      }.margin(5)
    }.width('100%')
    .margin({ top: 5 })
  }
}

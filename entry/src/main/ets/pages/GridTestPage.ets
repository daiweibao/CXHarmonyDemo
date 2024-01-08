@Entry
@Component
struct GridTestPage {
  @State services: Array<string> = ['会议', '投票', '签到', '打印', "烤翅", '鸡腿', '鸡头', '鸡脚']
  private scroller: Scroller = new Scroller()
  build() {
    Column(){
      Grid(this.scroller) {
        ForEach(this.services, item => {
          GridItem() {
            Text(item)
          }
          .height('60%')// 设置高度
          .backgroundColor('#36D')
        }, item => item)
      }
      .columnsTemplate('1fr 1fr')// 只设置columnsTemplate属性，当内容超出Grid区域时，可垂直滚动。
      .rowsGap(15)//行间距
      .columnsGap(20)//列间距
      .margin({top: 10, left: 10, bottom: 10, right: 10})//设置Grid外边距
      .height('80%')


      Row({space: 20}) {
        Button('上一页')
          .onClick(() => {
            // 点击后滑到上一页
            this.scroller.scrollPage({ next: false })
          })

        Button('下一页')
          .onClick(() => {
            // 点击后滑到下一页
            this.scroller.scrollPage({ next: true })
          })
      }
      .height('20%')
    }
    .height('100%')
  }
}
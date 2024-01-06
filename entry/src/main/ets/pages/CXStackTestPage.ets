@Entry
@Component
struct StackSample {
  private arr: string[] = ['APP1', 'APP2', 'APP3', 'APP4', 'APP5', 'APP6', 'APP7', 'APP8','APP9', 'APP10', 'APP11', 'APP12', 'APP13', 'APP14', 'APP15', 'APP16','APP17', 'APP18', 'APP19', 'APP20', 'APP21', 'APP22', 'APP23', 'APP24'];
  scroller: Scroller = new Scroller();
  build() {

    Column(){
      Scroll(this.scroller){
        Column(){
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.arr, (item) => {
              Text(item)
                .width(100)
                .height(100)
                .fontSize(16)
                .margin(10)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor(0xFFFFFF)
            }, item => item)
          }
          // .width('100%')

        }
        // .width('100%')




      }
      .height('90%')
      .backgroundColor(0xDCDCDC)
      .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹

      // Blank().layoutWeight(1)
      Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
        Text('联系人').fontSize(16)
        Text('设置').fontSize(16)
        Text('短信').fontSize(16)
      }
      // .alignSelf(Alignment.Bottom)
      .width('50%')
      .height(50)
      .backgroundColor('#16302e2e')
      .margin({ bottom: 15 })
      .borderRadius(15)


    }











  }
}

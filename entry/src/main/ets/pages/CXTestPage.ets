
@Entry
@Component
struct test {
  build() {
    //布局换行：Wrap
    Flex({wrap: FlexWrap.Wrap }) {
      Text('1、防守打法很多搜哈')
        // .width('50%')
        .height(50)
        .backgroundColor(0xF5DEB3)
        .margin({right: 15,bottom: 10})
      Text('2、热额公对公')
        // .width('50%')
        .height(50)
        .backgroundColor(0xD2B48C)
        .margin({right: 15,bottom: 10})
      Text('3、阿范德萨')
        // .width('50%')
        .height(50)
        .backgroundColor(0xD2B48C)
        .margin({right: 15,bottom: 10})
      Text('4、通融通融玩儿')
        // .width('50%')
        .height(50)
        .backgroundColor(0xD2B48C)
        .margin({right: 15,bottom: 10})
      Text('5、撒范德萨范德萨范德萨')
        // .width('50%')
        .height(50)
        .backgroundColor(0xD2B48C)
        .margin({right: 15,bottom: 10})
    }
    .width('100%')
    .padding(10)
    .backgroundColor(0xAFEEEE)
  }
}
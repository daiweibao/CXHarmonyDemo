@Entry
@Component
struct FlexTestPage {
  @State message: string = 'Hello World'

  build() {

    Flex({ direction: FlexDirection.Row }) {
      Text('flexShrink(3)')
        .fontSize(15)
        .flexShrink(3)
        .width(200)
        .height(100)
        .backgroundColor(0xF5DEB3)

      Text('no flexShrink')
        .width(200)
        .height(100)
        .backgroundColor(0xD2B48C)

      Text('flexShrink(2)')
        .flexShrink(2)
        .width(200)
        .height(100)
        .backgroundColor(0xF5DEB3)
    }.width(400).height(120).padding(10).backgroundColor(0xAFEEEE)

  }
}
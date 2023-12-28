// xxx.ets
@CustomDialog
struct CustomDialogExample {
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void
  build() {
    Column() {
      Text('我是内容').fontSize(20).margin({ top: 10, bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('cancel')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('confirm')
          .onClick(() => {
            this.controller.close()
            this.confirm()
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}

@Entry
@Component
struct AlertCXCenterViewPage {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: this.onCancel,
      confirm: this.onAccept,
    }),
    alignment: DialogAlignment.Default,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
  })
  onCancel() {
    console.log('Callback when the first button is clicked')
  }
  onAccept() {
    console.log('Callback when the second button is clicked')
  }

  build() {
    Flex({ justifyContent: FlexAlign.Center }) {
      Button('click me')
        .onClick(() => {
          this.dialogController.open()
        })
    }.width('100%')
  }
}

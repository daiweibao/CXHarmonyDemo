// xxx.ets
@Entry
@Component
struct SearchExample {
  @State changeValue: string = ''
  @State submitValue: string = ''
  controller: SearchController = new SearchController()

  build() {
    Column() {
      Text('最终搜索数据：' + this.submitValue).fontSize(18).margin(15)
      Text('输入框里数据：' + this.changeValue).fontSize(18).margin(15)
      //value：设置当前显示的搜索文本内容。
      //placeholder：设置无输入时的提示文本。
      //icon：设置搜索图标路径，默认使用系统搜索图标。
      //controller：设置Search组件控制器。
      Search({ value: this.changeValue, placeholder: '我是占位符', controller: this.controller })
        .searchButton('搜索')//搜索框末尾搜索按钮文本内容，默认无搜索按钮。
        .width(300)
        .height(40)
        .placeholderColor(Color.Grey)//设置placeholder文本颜色。
        .backgroundColor('#F5F5F5')
        .placeholderFont({ size: 14, weight: 400 })//设置搜索框内输入文本样式
        .textFont({ size: 14, weight: 400 })//设置搜索框内输入文本样式
        .onSubmit((value: string) => {
          //点击搜索图标、搜索按钮或者按下软键盘搜索按钮时触发该回调。
          this.submitValue = value
        })
        .onChange((value: string) => {
          //输入内容发生变化时，触发该回调。
          this.changeValue = value
        })
        .margin(20)

      Button('光标移动到第一位')
        .onClick(() => {
          //移动光标：设置光标位置到输入的第一个字符后
          this.controller.caretPosition(1)
        })
    }.width('100%')
  }
}

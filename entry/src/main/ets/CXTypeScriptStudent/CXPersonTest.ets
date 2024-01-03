//ts学习
let cxname = '你好'
console.log(cxname)











@Entry
@Component
struct CXPersonTest {
  @State message: string = '你好，世界！'
  build() {
    Column({space:20}){
      Text(this.message)

      //默认
      Text('This is the text content with textCase set to Normal.')
        .textCase(TextCase.Normal)
        .padding(10)
        .border({ width: 1 })
        .padding(10)
        .margin(5)

      // 文本全小写展示
      Text('This is the text content with textCase set to LowerCase.')
        .textCase(TextCase.LowerCase)
        .border({ width: 1 })
        .padding(10)
        .margin(5)

      // 文本全大写展示
      Text('This is the text content with textCase set to UpperCase.')
        .textCase(TextCase.UpperCase)
        .border({ width: 1 })
        .padding(10)
        .margin(5)

      Text("这是一段可复制文本")
        .fontSize(30)
        .copyOption(CopyOptions.InApp)
      Text('点我')
        .onClick(()=>{
          console.info('我是Text的点击响应事件');
        })



    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}





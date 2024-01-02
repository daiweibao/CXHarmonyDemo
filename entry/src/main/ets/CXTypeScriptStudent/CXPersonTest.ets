//ts学习
let cxname = '你好'
console.log(cxname)











@Entry
@Component
struct CXPersonTest {
  @State message: string = '你好，世界！'
  build() {
    Column(){
      Text(this.message)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}




import axios from '@ohos/axios'//导入头axios文件

@Entry
@Component
struct AxiosTestPage {
  @State message: string = 'Hello World'

  loadData(){
    
  }



  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button('发起网络请求').onClick((event: ClickEvent) => {
          axios.create()
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
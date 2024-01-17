// @ts-nocheck

import promptAction from '@ohos.promptAction'
import {CXTestSonComp} from '../CXComponents/CXTestSonComp'



@Entry
@Component
struct CXTestSonCompPage {
  @State message: string = ''

  //接收子组件里button的按钮点击事件
  handleTaskChange(name: string){
    //收到button按钮点击回调
    promptAction.showToast({message:'点击了按钮：'+name})
  }

  build() {
    Column() {
      //自定义子组件：把监听异步回调函数传进去（监听按钮点击事件）
      CXTestSonComp({onTaskChange:this.handleTaskChange})
        .height(200)
        .width(200)
        .backgroundColor(Color.Red)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Yellow)
  }
}
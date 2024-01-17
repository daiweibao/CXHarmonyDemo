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

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Yellow)
  }
}
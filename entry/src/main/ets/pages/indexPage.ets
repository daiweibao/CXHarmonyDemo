
import promptAction from '@ohos.promptAction'
import {CXHttpToolPromise} from '../CXComponents/CXTestSonComp'

@Entry
@Component
struct CXTestPage {
  build() {
    Column() {
      Text('点击回调数据')
        .onClick(()=>{
          //点击调用异步函数
          CXHttpToolPromise.then(value => {
            promptAction.showToast({message:'回调成功结果：'+value})
          })
            .catch((err)=>{
              promptAction.showToast({message:'回调失败'})
            })
        })
    }
  }
}

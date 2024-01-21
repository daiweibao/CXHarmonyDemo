import promptAction from '@ohos.promptAction'

@Entry
@Component
struct CXTestPage {

  //使用了await关键字来等待Promise对象的解析，并将其解析值存储在result变量中。
  async myAsyncFunction() {
    //异步网络请求
    const result = await new Promise((resolve, reject) => {
      //在这里发起网路请求。模拟3秒异步等待
      setTimeout(() => {
        let name: string = '123'
        if (name.length > 0) {
          resolve('网络请求成功回调数据')
        }else {
          reject('网络请求失败回调')
        }
      }, 3000);
    });

    //得到数据后，弹窗提示，或者做其他事，或者发起第二个异步请求
    promptAction.showToast({message:String(result)})// 输出：网络请求成功回调数据
  }

  build() {
    Column() {
      Button('点击回调数据啊')
        .onClick(()=>{
          //点击调用异步函数
          this.myAsyncFunction();
        })
        .backgroundImageSize({"width":"0vp","height":"0vp"})
        .backgroundColor('#ffff00ab')
    }
  }
}
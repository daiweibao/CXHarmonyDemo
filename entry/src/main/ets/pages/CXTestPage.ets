// xxx.ets

import {doSomething} from '../Model/CXTestTypeScript'

@Entry
@Component
struct CXTestPage {
  build() {
    Column() {
      Text('点击回调数据')
        .onClick(()=>{
          //点击调用异步函数
          test.then(res => {
            console.log('鹅鹅鹅饿',res);
          });
        })
    }
  }
}

const test = new Promise((reslove, reject) => {
  setTimeout(() => {
    let name:string = "张三";
    if (name.length>0){
      reslove(name);
    }else {
      reject(name);
    }
  }, 5000);
});


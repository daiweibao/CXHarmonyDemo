
//导出一个Promise对象
export const CXHttpToolPromise = new Promise(function(resolve, reject) {
  // 异步操作
  setTimeout(()=>{
    console.log('延迟2秒后执行')
    let a = '12'
    if (a.length > 0) {
      resolve('请求成功');
    } else {
      reject('请求失败');
    }
  },5000)
});
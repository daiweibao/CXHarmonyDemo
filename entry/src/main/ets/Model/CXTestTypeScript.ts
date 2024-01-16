

// 1. 创建一个需要执行的函数。
export function doSomething(callback) {
  console.log("调用了方法")

  setTimeout(()=>{
    console.log('延迟2秒后执行')
    callback()
  },2000)

}





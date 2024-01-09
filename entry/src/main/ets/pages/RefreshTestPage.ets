// xxx.ets
@Entry
@Component
struct RefreshExample {
  //记录刷新状态
  @State isRefreshing: boolean = false
  //UI展示
  @State counter: number = 0

  build() {
    Column() {
      //isRefreshing参数支持$$双向绑定变量
      Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
        //文本
        Text('下拉刷新次数记录: ' + this.counter)
          .fontSize(30)
          .margin(10)
      }
      .height('100%')//刷新控件高度
      .onStateChange((refreshStatus: RefreshStatus) => {
        //当前刷新状态变更时，触发回调。
        console.info('刷新状态改变，当前刷新状态：' + refreshStatus)
      })
      .onRefreshing(() => {
        //进入刷新状态时触发回调。
        console.log('进入刷新状态')
        //模拟1秒后结束刷新
        setTimeout(() => {
          this.isRefreshing = false
          this.counter++//IU展示
          console.log('结束刷新')
        }, 3000)
      })
    }
    .height('100%')
  }
}

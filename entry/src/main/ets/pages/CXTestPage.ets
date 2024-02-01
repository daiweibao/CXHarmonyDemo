@Entry
@Component
struct CXTabsMainPage2 {
  @State message: string = 'Hello World'

  build() {
    //创建tabbar，默认在顶部，通过barPosition设置位置，End代表底部
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        //显示在控制器上的内容
        Text('首页的内容').fontSize(30)
      }
      .tabBar('首页')//每一个TabContent对应的内容需要有一个页签tabBar
      .backgroundColor(Color.Yellow)//设置首页控制器颜色


      TabContent() {
        Text('推荐的内容').fontSize(30)
      }
      .tabBar('推荐')

      TabContent() {
        Text('发现的内容').fontSize(30)
      }
      .tabBar('发现')

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .tabBar("我的")
    }
    .barWidth('100%') // 设置TabBar宽度
    .barHeight(60) // 设置TabBar高度
    .width('100%') // 设置Tabs组件宽度
    .height('100%') // 设置Tabs组件高度
    .backgroundColor(Color.Red) // 设置Tabs组件背景颜色
  }
}


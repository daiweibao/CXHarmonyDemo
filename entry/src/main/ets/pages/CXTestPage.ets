@Entry
@Component
struct CXTabsMainPage2 {
  //切换指定页签需要使用TabsController，TabsController是Tabs组件的控制器，用于控制Tabs组件进行页签切换。通过TabsController的changeIndex方法来实现跳转至指定索引值对应的TabContent内容。
  private tabsController: TabsController = new TabsController()
  //记录tabbar选中的角标
  @State currentIndex: number = 0;

  build() {
    //创建tabbar，默认在顶部，通过barPosition设置位置，End代表底部
    //使用自定义导航栏时要传入controller参数
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController}) {
      TabContent() {
        Text('首页的内容').fontSize(30)
      }
      //调用自定义tabbar
      .tabBar(this.TabBuilder('首页', 0, $r('app.media.ic_tabbar_homeS'), $r('app.media.ic_tabbar_home')))

      TabContent() {
        Text('推荐的内容').fontSize(30)
      }
      .tabBar(this.TabBuilder('推荐', 1, $r('app.media.ic_tabbar_twoS'), $r('app.media.ic_tabbar_two')))

      TabContent() {
        Text('发现的内容').fontSize(30)
      }
      .tabBar(this.TabBuilder('发现', 2, $r('app.media.ic_tabbar_threeS'), $r('app.media.ic_tabbar_three')))

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .tabBar(this.TabBuilder('我的', 3, $r('app.media.ic_tabbar_myS'), $r('app.media.ic_tabbar_my')))
    }
    .backgroundColor(Color.Orange)
    .onChange((index) => {
      //自定义tabbar，需要监听索引index的变化，实现左右滑动切换tabbar的图标文字
      this.currentIndex = index
    })
  }

  // 里声明TabBuilder的自定义函数组件，传入参数包括页签文字title，对应位置index，以及选中状态和未选中状态的图片资源。通过当前活跃的currentIndex和页签对应的targetIndex匹配与否，决定UI显示的样式。
  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      //图片属性
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      //文字属性
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      //点击切换到指定标签
      this.currentIndex = targetIndex;
      //通过TabsController的changeIndex方法来实现跳转至指定索引值对应的TabContent内容。
      this.tabsController.changeIndex(this.currentIndex);
    })
  }
}
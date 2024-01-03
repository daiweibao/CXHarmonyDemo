//Navigation演示
@Entry
@Component
struct CXNavigationTestPage {
  @State message: string = 'Hello World'

  build() {
    Column({space: 10}) {
      Navigation() {
      }
      .title('帝心')//设置标题
      .hideTitleBar(false)//是否隐藏标题
      .toolBar({items: [{
        value: '点赞'
      },
        {
          value: '投币'
        }
      ]
      })
      .mode(NavigationMode.Auto)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F1F1')
  }
}


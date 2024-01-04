//Navigation+toolBar演示
@Entry
@Component
struct CXNavigationTestPage {
  //记住当前选中哪一个角标
  @State cIndex: number = 0
  //toolBar数据
  @State bars: Array<{ text: string, num: number, img: Resource, content: Resource}> = [
    {
      text: '首页',
      num: 0,
      img: $r('app.media.ic_tabbar_home'),
      content: $r('app.media.ic_tabbar_homeS')
    },
    {
      text: '朋友',
      num: 1,
      img: $r('app.media.ic_tabbar_two'),
      content: $r('app.media.ic_tabbar_twoS')
    },
    {
      text: '我的',
      num: 2,
      img: $r('app.media.ic_tabbar_my'),
      content: $r('app.media.ic_tabbar_myS')
    },
  ]

  build() {
    Navigation() {
      if (this.cIndex===0){
        //套一个容器，方便布局，也可以不套
        Column({space: 10}){
          // 导航区内容【显示第一个页面的内容】
          Text('第一个页面的其他内容')
            .width('100%')
            .height(50)
            .textAlign(TextAlign.Center)

          //【1】 NavRouter导航组件，默认提供点击响应处理【需要有点击跳转的内容套上NavRouter来实现跳转】
          NavRouter() {
            Text('第二个页面：新闻详情')
              .fontSize(22)
              .textAlign(TextAlign.Center)

            // NavRouter组件的子组件，用于显示导航内容区。【里面显示第二个页面的内容】
            NavDestination() {
              //这里放第二个页面的内容
              Text('这里展示新闻详情内容')
                .height('100%')
                .width('100%')
                .textAlign(TextAlign.Center)
                .fontColor(Color.Green)
            }
            .backgroundColor(Color.Red)//第二个页面的背景颜色
            // 设置第二个页面导航标题
            .title('新闻详情')

          }
          .width('100%')
          .height(100)//需要导航的内容区域高度，可点击区域
          .backgroundColor(Color.Orange)

          //【2】 NavRouter导航组件，默认提供点击响应处理【需要有点击跳转的按钮加上NavRouter来实现导航】
          NavRouter() {
            Column() {
              Text('第二个页面：商品详情')
                .fontSize(22)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)

            // NavRouter组件的子组件，用于显示导航内容区。【里面显示第二个页面的内容】
            NavDestination() {
              //这里放第二个页面的内容
              Text('这里展示商品详情内容')
                .height('100%')
                .width('100%')
                .textAlign(TextAlign.Center)
                .fontColor(Color.Green)
            }
            .backgroundColor(Color.Green)//第二个页面的背景颜色
            // 设置第二个页面导航标题
            .title('商品详情')

          }
          .width('100%')
          .height(100)//需要导航的内容区域高度，可点击区域
          .backgroundColor(Color.Orange)

        }
        .height('100%')

      }else if (this.cIndex===1){
        //朋友页面
        Text('朋友页面内容')
          .fontSize(22)
          .textAlign(TextAlign.Center)

      }else if (this.cIndex==2){
        //我的页面
        Text('我的页面内容')
          .fontSize(22)
          .textAlign(TextAlign.Center)
      }
    }
    .title(this.NavigationTitle())//设置标题
    .hideTitleBar(false)//是否隐藏标题
    .toolBar(this.NavigationToolbar())//设置底部bar
    .mode(NavigationMode.Auto)//设置自适应模式
    .titleMode(NavigationTitleMode.Mini)//顶不标题模式
    .menus([{value: "", icon:"./media/ic_public_add.svg" , action: ()=>{}},
      {value: "", icon: "./image/ic_public_add.svg", action: ()=>{}},
      {value: "", icon: "./image/ic_public_add.svg", action: ()=>{}}])
  }

  //顶部标题
  @Builder NavigationTitle(){
    Column({space: 10}){
      Text(this.bars[this.cIndex].text).fontSize(26).fontColor(0x3E3E3E)
    }
  }

  //底部图片
  @Builder NavigationToolbar(){
    Row(){
      ForEach(this.bars, item => {
        Column({space: 10}){
          Image(
            //设置选中和非选中的图片
              this.cIndex === item.num ?item.content: item.img
          )
            .width(25)
            .height(25)
          Text(item.text).fontSize(15).fontColor(
            //点击改变文字颜色
            this.cIndex === item.num ? Color.Blue : 0x3E3E3E
          )
        }
        .width(120)
        .height(50)
        .onClick(()=>{
          //底部标签点击事件，点击切换角标
          this.cIndex = item.num
        })
      })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}







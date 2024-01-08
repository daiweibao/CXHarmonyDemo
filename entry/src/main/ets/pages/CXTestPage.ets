@Entry
@Component
struct MyComponent {
  @State isVisible: boolean = true;
  private listScroller: Scroller = new Scroller();
  build() {
    List({ space: 20, scroller: this.listScroller }) {
      ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], item => {
        ListItem(){
          //ListItem内部，只能包含一个根组件
          Text(`${item}`)
            // .width('90%')
            // .height(100)
            .backgroundColor(Color.Orange)
            // .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(100)
        // .backgroundColor(Color.Green)
      })
    }
    .alignListItem(ListItemAlign.Center)
    .width('100%')
    .listDirection(Axis.Vertical)//列表方向，默认纵向（垂直）
    // .lanes(2)

    .divider({
      startMargin: 60,//分隔线距离列表侧边起始端的距离
      endMargin: 10,//距离列表侧边结束端的距离
      strokeWidth: 1,//分割线粗细
      color: '#ffe9f0f0'
    })

    .scrollBar(BarState.Auto)//添加滚动条
  }
}






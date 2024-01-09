@Entry
@Component
struct MyComponent {
  @State isVisible: boolean = true;
  private listScroller: Scroller = new Scroller();
  build() {
    List({ space: 20, scroller: this.listScroller }) {
      ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (item, index) => {
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
        .swipeAction({start: this.DeleteButton(index)})//添加cell侧滑删除按钮
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
    .onScrollIndex((firstIndex: number,endIndex: number) => {
     console.log(`滚动：${firstIndex}===${endIndex}`)
    })

  }

  //删除按钮函数封装
  @Builder DeleteButton(index: number){
    //删除按钮
    Button(){
      //按钮上的图片
      Image($r('app.media.ic_public_delete'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Orange)
    .margin(10)
    .onClick(() => {
      //删除按钮点击事件，index是对应的cell角标

    })
    .size({width: 100, height: 50})
    .padding(10)
  }

}









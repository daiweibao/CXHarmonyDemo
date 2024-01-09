@Entry
@Component
struct MyComponent {
  @State isVisible: boolean = true;
  private listScroller: Scroller = new Scroller();
  build() {
    Column(){
      Text('测试')
        .width(200)
        .height(200)
        .backgroundColor(Color.Orange)
        .position({
          x:30,
          y:80
        })
        .offset({
          x:30,
          y:80
        })
        .border({
          width:{//分别设置4边框宽度，也可以直接设置4边框一样宽：width:10
            top:10,
            left:20,
            bottom:30,
            right:40
          },//边框宽度
          color:{//分别设置4个边框颜色，也可以直接设置4边框颜色一样：Color.Green
            top:Color.Red,
            left:Color.Yellow,
            bottom:Color.Blue,
            right:Color.Green
          },
          radius:{//分别设置4个圆角大小。也可以直接设置4个圆角大小一样：radius:10
            topLeft:5,
            topRight:10,
            bottomLeft:5,
            bottomRight:20
          },
          style:{//设置边框样式，也可以直接设置4边一样：style:BorderStyle.Dotted
            top:BorderStyle.Dotted,//Dotted：显示为一系列圆点
            left:BorderStyle.Dashed,//Dashed：显示为一系列短的方形虚线
            bottom:BorderStyle.Solid,//Solid：显示为一条实线。
            right:BorderStyle.Dotted
          }
        })
        .border({
          width:10,//边框宽度
          color:Color.Red,//边框颜色
          radius:20,//圆角大小
          style:BorderStyle.Solid//边框样式
        })
    }
    .height('100%')
    .width('100%')
  }
}









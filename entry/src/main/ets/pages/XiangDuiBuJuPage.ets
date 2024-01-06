///相对布局案例演示
@Entry
@Component
struct Index {
  build() {
    Row() {
      RelativeContainer() {
        Row(){
          Text('row1')
        }
        .width(100)
        .height(100)
        .backgroundColor('#FF3333')
        .alignRules({
          //row1顶部 与 父视图顶部 对齐
          top: { anchor: '__container__', align: VerticalAlign.Top },  //以父容器为锚点，竖直方向顶头对齐
          //row1水平中间 与 父视图中间 对齐
          middle: { anchor: '__container__', align: HorizontalAlign.Center }  //以父容器为锚点，水平方向居中对齐
        })
        .id('row1')  //设置锚点为row1

        Row() {
          Stack(){
            Image($r('app.media.icon'))
            Text('row2').fontColor(Color.Red).fontSize(30)
          }
        }
        .height(100).width(100)
        .alignRules({
          //row2顶部 与 row1底部 对齐
          top: { anchor: 'row1', align: VerticalAlign.Bottom },  //以row1组件为锚点，竖直方向低端对齐
          //row2左边 与 row1左边 对齐
          left: { anchor: 'row1', align: HorizontalAlign.Start }  //以row1组件为锚点，水平方向开头对齐
        })
        .id('row2')  //设置锚点为row2

        Row(){
          Text('row3')
        }
        .width(100)
        .height(100)
        .backgroundColor('#FFCC00')
        .alignRules({
          //row3顶部 与 row2顶部 对齐
          top: { anchor: 'row2', align: VerticalAlign.Top }
        })
        .id('row3')  //设置锚点为row3

        Row(){
          Text('row4')
        }
        .width(100)
        .height(100)
        .backgroundColor('#FF9966')
        .alignRules({
          //row4顶部 与 row2顶部 对齐
          top: { anchor: 'row2', align: VerticalAlign.Top },
          //row4左边 与 row2右边 对齐
          left: { anchor: 'row2', align: HorizontalAlign.End },
        })
        .id('row4')  //设置锚点为row4

        Row(){
          Text('row5')
        }
        .width(100)
        .height(100)
        .backgroundColor('#FF66FF')
        .alignRules({
          //row5顶部 与 row2底部 对齐
          top: { anchor: 'row2', align: VerticalAlign.Bottom },
          //row5水平中间 与 row2中间 对齐
          middle: { anchor: 'row2', align: HorizontalAlign.Center }
        })
        .id('row5')  //设置锚点为row5
      }
      .width(300).height(300)
      .border({ width: 2, color: '#6699FF' })
    }
    .height('100%').margin({ left: 30 })
  }
}


//商品列表案列：-List能滚动

//数据模型
class Item {
  name: string //商品名字
  image: ResourceStr //图片
  price: number //价格
  discount: number //折扣价格

  constructor(name: string, image: ResourceStr, price: number, discount: number = 0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount = discount
  }
}


@Entry
@Component
struct CXListItemPage {
  @State message: string = 'Hello World'

  //商品数据
  private items: Array<Item> = [
    new Item('华为Mate60', $r('app.media.chaoxiheader'), 6999, 500),
    new Item('MateBookProX', $r('app.media.chaoxiheader'), 13999),
    new Item('WatchGT4', $r('app.media.chaoxiheader'), 1438),
    new Item('FreeBuds Pro3', $r('app.media.chaoxiheader'), 1499),
    new Item('Mate X5', $r('app.media.chaoxiheader'), 12999),
    new Item('Mate X5', $r('app.media.chaoxiheader'), 12999),
    new Item('Mate X5', $r('app.media.chaoxiheader'), 12999),
    new Item('Mate X5', $r('app.media.chaoxiheader'), 12999)
  ]

  build() {
    Column({ space: 8 }) {
      //标题
      Row() {
        Text('商品列表')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(30)
      .margin({ bottom: 20 })

      List({ space: 10 }) {
        //循环控制组件
        ForEach(this.items, (item: Item) => {
          ListItem(){
            Row({ space: 10 }) {

              //商品封面图
              Image(item.image)
                .width(100)

              Column({ space: 4 }) {
                if (item.discount) {
                  //有折扣
                  //商品名字
                  Text(item.name)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)

                  //商品价格
                  Text('原价：￥' + item.price)
                    .fontSize(18)
                    .fontColor('#CCC')
                    .decoration({type: TextDecorationType.LineThrough})//文字中划线

                  //折扣
                  Text('折扣价：' + (item.price-item.discount))
                    .fontSize(18)
                    .fontColor('#F36')
                  //补贴价
                  Text('补贴：' + item.discount)
                    .fontSize(18)
                    .fontColor('#F36')

                }else {
                  //无折扣
                  //商品名字
                  Text(item.name)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)

                  //商品价格
                  Text('￥' + item.price)
                    .fontSize(18)
                    .fontColor('#F36')
                }
              }
              .height('100')
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .backgroundColor('#FFF')
            .borderRadius(20)
            .height(120)
            .padding(10)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)//父容器尺寸确定时，使用layoutWeight属性设置子元素和兄弟元素在主轴上的权重，忽略元素本身尺寸设置，使它们在任意尺寸的设备下自适应占满剩余空间。
      .listDirection(Axis.Vertical) //列表方向，默认纵向（垂直）
      .scrollBar(BarState.On) // 滚动条常驻
      .edgeEffect(EdgeEffect.Spring) // 滚动到边缘再拖动回弹效果

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EFEFEF')
    .padding(20)
  }
}

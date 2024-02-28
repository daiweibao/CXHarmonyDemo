@Entry
@Component
struct CXMeiTuanPage {
  //是否显示购物车
  @State showCart: boolean = false

  build() {
    Stack({alignContent:Alignment.Bottom}){
      //主内容器组件
      MTMain()
      if (this.showCart){
        //购物车组件
        MTCart()
      }
      //底部组件
      MTBottom({showCart:$showCart})


    }.height('100%')
  }
}

//购物车组件
@Component
struct MTCart {
  build() {
    Column(){
      Row(){
        Text('购物车')
          .fontSize(12)
        Text('清空购物车')
          .fontSize(12)
          .fontColor('#999')
      }
      .width('100%')
      .height(40)
      .padding({left:15,right:15})
      .border({
        color:'#f5f5f5',
        width:{
          bottom:0.5
        }
      })
      .justifyContent(FlexAlign.SpaceBetween)

      List({ space: 30 }) {
        ForEach([1,2,3,4], () => {
          ListItem() {
            MTCartItem()
          }
        })
      }
    }
    .height('50%')
    .width('100%')
    .backgroundColor(Color.White)
  }
}

//主容器组件
@Component
struct MTMain {
  @State list:string[] = ['一人套餐','特色烧烤','杂粮主食']
  @State selectIndex: number = -1
  build() {
    Column(){
      //顶部导航
      MTNav()
      //左边是分类、右侧是菜品
      Row(){
        //左侧分类
        Column(){
          ForEach(this.list,(item: string, index: number)=> {
            Text(item)
              .height(50)
              .width('100%')
              .fontSize(14)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.selectIndex===index? '#ffff': '#f5f5f5')
              .onClick(() => {
                this.selectIndex = index
              })
          })
        }
        .width(90)
        .height('100%')
        .backgroundColor('#f5f5f5')
        //右侧是内容
        List(){
          ListItem(){
            MTFoodItem()
          }
          ListItem(){
            MTFoodItem()
          }
          ListItem(){
            MTFoodItem()
          }
          ListItem(){
            MTFoodItem()
          }
          ListItem(){
            MTFoodItem()
          }
          ListItem(){
            MTFoodItem()
          }

          ListItem(){
            MTFoodItem()
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Auto)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Top)
      .width('100%')
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.White)
  }
}

//顶部导航
@Component
struct MTNav {
  @Builder
  NavItem(active: boolean, title: string, subTitle?: string) {
    Column() {
      Text() {
        Span(title)
        if (subTitle) {
          Span(' ' + subTitle)
            .fontSize(10)
            .fontColor(active ? '#000' : '#666')
        }
      }.layoutWeight(1)
      .fontColor(active ? '#000' : '#666')
      .fontWeight(active ? FontWeight.Bold : FontWeight.Normal)

      Text()
        .height(1)
        .width(20)
        .margin({ left: 6 })
        .backgroundColor(active ? '#fa0' : 'transparent')
    }
    .width(73)
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 3 })
  }

  build() {
    Row() {
      this.NavItem(true, '点菜')
      this.NavItem(false, '评价', '1796')
      this.NavItem(false, '商家')
      Row() {
        Image($r('app.media.ic_public_input_search'))
          .width(14)
          .aspectRatio(1)
          .fillColor('#999')
        Text('请输入菜品名称')
          .fontSize(12)
          .fontColor('#999')
      }
      .backgroundColor('#eee')
      .height(25)
      .borderRadius(13)
      .padding({ left: 5, right: 5 })
      .layoutWeight(1)

    }
    .padding({ left: 15, right: 15 })
    .height(40)
    .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
  }
}

// 主页的结构的菜品单项组件
@Component
struct MTFoodItem {
  build() {
    Row() {
      Image('https://zqran.gitee.io/images/waimai/8078956697.jpg')
        .width(90)
        .aspectRatio(1)
      Column({ space: 5 }) {
        Text('小份酸汤莜面鱼鱼+肉夹馍套餐')
          .textOverflow({
            overflow: TextOverflow.Ellipsis,////设置文本超出边界尾部省略号显示
          })
          .maxLines(2)//显示2行
          .fontWeight(600)
        Text('酸汤莜面鱼鱼，主料：酸汤、莜面 肉夹馍，主料：白皮饼、猪肉')
          .textOverflow({
            overflow: TextOverflow.Ellipsis,
          })
          .maxLines(1)
          .fontSize(12)
          .fontColor('#333')
        Text('点评网友推荐')
          .fontSize(10)
          .backgroundColor('#fff5e2')
          .fontColor('#ff8000')
          .padding({ top: 2, bottom: 2, right: 5, left: 5 })
          .borderRadius(2)
        Text() {
          Span('月销售40')
          Span(' ')
          Span('好评度100%')
        }
        .fontSize(12)
        .fontColor('#999')

        Row() {
          Text() {
            Span('¥ ')
              .fontColor('#ff8000')
              .fontSize(10)
            Span('34.23')
              .fontColor('#ff8000')
              .fontWeight(FontWeight.Bold)
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10, right: 10 })
    }
    .padding(10)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct MTCartItem {
  build(){
    Row(){
      Image('https://zqran.gitee.io/images/waimai/7384994864.jpg')
        .width(60)
        .aspectRatio(1)
        .borderRadius(8)
      Column({space:5}){
        Text('腐恶费恶搞日光灯管个咕嘟咕嘟发光飞碟')
          .fontSize(14)
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })
          .maxLines(2)

        Row(){
          Text(){
            Span('￥')
              .fontSize(12)
              .fontColor('#fff800')
            Span('34.33')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#fff800')
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10, right: 10 })
    }
    .alignItems(VerticalAlign.Top)
  }
}

//底部组件
@Component
struct MTBottom {
  @Link showCart: boolean
  build(){
    Row(){
      Row(){
        //角标组件
        Badge({
          value:'1',
          position:BadgePosition.Right,
          style:{
          badgeSize:18
        }
        }){
          //要显示的结构是什么
          Image('/pages/MeiTuan/waimai.png')
            .width(47)
            .height(69)
            .position({
              y:-20
            })
        }
        .width(50)
        .height(50)
        .margin({left:25,right:10})

        //右边的 配送费和价格
        Column(){
          Text(){
            Span('￥')
              .fontSize(12)
              .fontColor(Color.White)
            Span('0.00')
              .fontSize(24)
              .fontColor(Color.White)
          }
          //配送费
          Text('预估另需配送费￥5')
            .fontSize(12)
            .fontColor(Color.White)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        //结算按钮
        Text('去结算')
          .height('100%')
          .backgroundColor('#f8c74e')
          .borderRadius({
            topRight:30,
            bottomRight:30
          })
          .padding({
            left:15,
            right:15
          })

      }
      .height(60)
      .width('100%')
      .backgroundColor('#222426')
      .borderRadius(30)
      .onClick(()=>{
        this.showCart = !this.showCart
      })
    }
    .width('100%')
    .padding({
      left:20,
      right:20,
      bottom:20
    })
  }
}
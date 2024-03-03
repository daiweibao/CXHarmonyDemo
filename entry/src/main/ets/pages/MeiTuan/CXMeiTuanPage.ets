import http from '@ohos.net.http'

@Entry
@Component
struct CXMeiTuanPage {
  //是否显示购物车
  @State showCart: boolean = false
  @State list: Category[] = [] // 声明数据结构
  //购物车数据
  @StorageLink('user_cart') @Watch('updateCartJSON') cartJSON : string = ''

  @Provide cartList: FoodItem[] = []

  //获取数据，蒋数据动态渲染
  aboutToAppear(){
    //美团餐数据
    this.getMTData()
    //初始化监听方法
    this.updateCartJSON()
  }
//监听到数据变化，更新购物车数据
  updateCartJSON(){
    this.cartList = getCarts()
  }

  async getMTData(){
    try {
      const req = http.createHttp()
      const res = await req.request("https://zhoushugang.gitee.io/fe2022/takeaway.json")
      //对象转模型
      this.list = JSON.parse(res.result as string) as Category[]

    } catch (error) {

    }
  }

  build() {
    Stack({alignContent:Alignment.Bottom}){
      //主内容器组件
      MTMain({list:$list})
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
  @Consume cartList: FoodItem[]
  build() {
    Column(){
      Row(){
        Text('购物车')
          .fontSize(12)
        Text('清空购物车')
          .fontSize(12)
          .fontColor('#999')
          .onClick(()=>{
            //清空购物车
            cleaseCarts()
          })
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
        ForEach(this.cartList, (item:FoodItem,index:number) => {
          ListItem() {
            MTCartItem({item:item})
          }
        })
      }
      .divider({
        strokeWidth: 0.5,
        color: '#f5f5f5'
      })
      .padding({ left: 15, right: 15, bottom: 70 })
    }
    .height('50%')
    .width('100%')
    .backgroundColor(Color.White)
  }
}

//主容器组件
@Component
struct MTMain {
  @Link list:Category[]
  // @State list:string[] = ['一人套餐','特色烧烤','杂粮主食']
  @State selectIndex: number = 0
  build() {
    Column(){
      //顶部导航
      MTNav()
      //左边是分类、右侧是菜品
      Row(){
        //左侧分类
        Column(){
          ForEach(this.list,(item: Category, index: number)=> {
            Text(item.name)
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
          //数组元素不存在的时候处理（数据不存在用[]代替）：this.list[this.selectIndex]?.foods || []
          ForEach(this.list[this.selectIndex]?.foods || [],(item:FoodItem,index:number)=>{
            ListItem(){
              MTFoodItem({item:item})
            }
          })
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
  item:Partial<FoodItem> = {}
  build() {
    Row() {
      Image(this.item.picture)
        .width(90)
        .aspectRatio(1)
      Column({ space: 5 }) {
        Text(this.item.name)
          .textOverflow({
            overflow: TextOverflow.Ellipsis,////设置文本超出边界尾部省略号显示
          })
          .maxLines(2)//显示2行
          .fontWeight(600)
        Text(this.item.description)
          .textOverflow({
            overflow: TextOverflow.Ellipsis,
          })
          .maxLines(1)
          .fontSize(12)
          .fontColor('#333')
        Text(this.item.unit)
          .fontSize(10)
          .backgroundColor('#fff5e2')
          .fontColor('#ff8000')
          .padding({ top: 2, bottom: 2, right: 5, left: 5 })
          .borderRadius(2)
        Text() {
          Span(`月销售${this.item.month_saled}`)
          Span(' ')
          Span(this.item.like_ratio_desc)
        }
        .fontSize(12)
        .fontColor('#999')

        Row() {
          Text() {
            Span('¥ ')
              .fontColor('#ff8000')
              .fontSize(10)
            Span(this.item.price.toFixed(2))
              .fontColor('#ff8000')
              .fontWeight(FontWeight.Bold)
          }
          //加减号
          MTAddCut({item:this.item})
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
  item: Partial<FoodItem> = {}
  build(){
    Row(){
      Image(this.item.picture)
        .width(60)
        .aspectRatio(1)
        .borderRadius(8)
      Column({space:5}){
        Text(this.item.name)
          .fontSize(14)
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })
          .maxLines(2)

        Row(){
          Text(){
            Span('￥')
              .fontSize(12)
              .fontColor('#ff800')
            Span(this.item.price.toFixed(2))
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#ff800')
          }

          //加减号
          MTAddCut({item: this.item})
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
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

  @Consume cartList: FoodItem[]

  //购物车的总数量
  getAllCount(){
    //计算数组里count字段的总数：cartList是数组，item.count是商品数量;后面0表示preValve默认值从0开始
   return this.cartList.reduce((preValve:number, item:FoodItem)=>{
      return preValve +item.count
    },0)
  }

  //购物车的总价格
  getAllPricr(){
    //计算数组里count字段的总数：cartList是数组，item.count是商品数量;后面0表示preValve默认值从0开始
    return this.cartList.reduce((preValve:number, item:FoodItem)=>{
      return preValve + item.count * item.price
    },0)
  }

  build(){
    Row(){
      Row(){
        //角标组件
        Badge({
          value:this.getAllCount().toString(),
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
            Span(this.getAllPricr().toFixed(2))
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

//加减菜组件
@Component
struct MTAddCut {
  @Consume cartList: FoodItem[]
  item:Partial<FoodItem> = {}

  //获取要显示的数量
  getContent(): number{
   return this.cartList.find(obj => obj.id === this.item.id)?.count || 0
  }


  build(){
    Row({space:8}){
      Row(){
        Image($r('app.media.ic_screenshot_line'))
          .width(10)
          .aspectRatio(1)
      }
      .width(16)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#fff')
      .borderRadius(4)
      .border({
        width:0.5,
        color:'#f8c74e'
      })
      .visibility(this.getContent() ? Visibility.Visible : Visibility.Hidden)
      .onClick(()=>{
        addCutCart('cut',this.item as  FoodItem)
      })

      Text(this.getContent().toString()).fontSize(14)
        .visibility(this.getContent() ? Visibility.Visible : Visibility.Hidden)
      Row(){
        Image($r('app.media.ic_public_add_filled'))
          .width(10)
          .aspectRatio(1)
      }
      .width(16)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#f8c74e')
      .borderRadius(4)
      .onClick(()=>{
        addCutCart('add',this.item as FoodItem)
      })
    }
  }
}

//class类型
class Category {
  tag: string = ''
  name: string = ''
  foods: FoodItem[] = []
}
//Category数据中嵌套的数据
export class FoodItem {
  id: number = 0
  name: string = ""
  like_ratio_desc: string = ""
  month_saled: number = 0
  unit: string = ""
  food_tag_list: string[] = []
  price: number = 0
  picture: string = ""
  description: string = ""
  tag: string = ""
  count: number = 0
}


//持久化购物车数据
PersistentStorage.PersistProp<string>('user_cart', '[]')

//加减购物车的方法
const addCutCart = (type: 'add' | 'cut', item:FoodItem)=>{
  const list = getCarts()
  const f = list.find(f => f.id === item.id)//找元素
  if (type==='add'){
    //加
    if (f){
      //找到了
      f.count++
    }else {
      item.count=1
      list.unshift(item)//在第一诶插入一个数组元素
    }
  }else {
    //减
    if (f && f.count>0){
      f.count--
      if (f.count===0){
        //从购物车中移除菜品
        const index = list.findIndex(ff => ff.id === item.id)
        //移除菜品数据
        list.splice(index,1)
      }
    }
  }
  //list发生变化或者没发生，都要写入磁盘
  AppStorage.Set<string>('user_cart', JSON.stringify(list))

  // AlertDialog.show({
  //   message:AppStorage.Get<string>('user_cart')
  // })

}

//获取购物车里面所有数据
const getCarts = ()=>{
  return JSON.parse( AppStorage.Get<string>('user_cart' || '[]')) as FoodItem[]
}

const cleaseCarts = () =>{
  AppStorage.Set<string>('user_cart','[]')
}

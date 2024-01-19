
import { CXNavView } from '../CXComponents/CXNavComponent'//导航栏封装
import shopListModel from '../ViewModel/ShopListModel'
import ShopItem from '../Views/ShopItem'
import httpTools from '../Model/CXHttpTools'

@Entry
@Component
struct ShopPage {
  //数据源
  @State dataSouce: Array<shopListModel> = []

  aboutToAppear(){
    //加载网络数据
    this.loadDataShopInfo()
  }

  build()  {
    Column({space: 10}) {
      CXNavView({navTitle:'商铺列表'})//导航栏
      List({space: 10}) {
        ForEach(this.dataSouce, shopModel => {
          ListItem(){
            //item封装
            ShopItem({shopModel:shopModel})
              .width('100%')
          }
          .backgroundColor(Color.White)
          .margin({left:15,right:15})
          .borderRadius(10)
        })
      }
      .padding({top:15})
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#EDEDEC')
      .onReachEnd(() => {
        //滑动到了底部
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  //网络数据
  loadDataShopInfo(){
    // TODO 加载数据
    //网络接口
    let path = 'http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?'
    //参数
    let parm = {'cityId':'101040100'}

    //发起网络请求
    httpTools.postWithURL(path,parm).then(data => {
      console.log('控制器里请求结果：',data)
      //数据转模型：data数据转对象后用模型接收
      let shopModel: shopListModel = JSON.parse(data.toString())
      //标题
      shopModel.name = `天气：${shopModel.weatherinfo.weather}`
      //描述
      shopModel.content = '这是今天的天气情况，还是挺不错的啊'
      //图片
      shopModel.image = 'https://upload-images.jianshu.io/upload_images/1521667-aa76f7b8b3efec86.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/606'
      this.dataSouce.push(shopModel)

      //第2条数据
      let shopModel2: shopListModel = JSON.parse(data.toString())
      //名字
      shopModel2.name = `风向：${shopModel.weatherinfo.WD}`
      //描述
      shopModel2.content = '今天风力比较大，不太适合出去玩呀'
      //图片
      shopModel2.image = 'https://upload-images.jianshu.io/upload_images/1521667-d1f70564b2a6c187?imageMogr2/auto-orient/strip%7CimageView2/2/w/640'
      this.dataSouce.push(shopModel2)

      //添加10条数据
      for (let index = 0; index < 10; index++) {
        this.dataSouce.push(shopModel)
        this.dataSouce.push(shopModel2)
      }
    }).catch(err => {
      console.log('请求失败：',String(err))
    })
  }
}







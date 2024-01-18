
import { CXNavView } from '../CXComponents/CXNavComponent'
import ShopInfo from '../ViewModel/ShopInfo'
import ShopItem from '../Views/ShopItem'

import httpTools from '../Model/CXHttpTools'
import data from '@ohos.telephony.data'

@Entry
@Component
struct ShopPage {
  @State shopArray: Array<ShopInfo> = []

  aboutToAppear(){
    //加载网络数据
    this.loadShopInfo()
  }

  build()  {
    Column({space: 10}) {
      CXNavView({navTitle:'商铺列表'})
      List({space: 10}) {
        ForEach(this.shopArray, shop => {
          ListItem(){
            ShopItem({shop:shop})
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
  loadShopInfo(){
    // TODO 加载数据
    let path = 'http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?'
    let parm = {'cityId':'101040100'}

    //发起网络请求
    httpTools.postWithURL(path,parm).then(data => {
      console.log('控制器里请求结果：',data)
      //第1条数据
      let shopModel: ShopInfo = JSON.parse(data.toString())
      //标题
      shopModel.name = `天气：${shopModel.weatherinfo.weather}`
      //描述
      shopModel.content = '这是今天的天气情况，还是挺不错的啊'
      //图片
      shopModel.image = 'https://upload-images.jianshu.io/upload_images/1521667-aa76f7b8b3efec86.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/606'
      this.shopArray.push(shopModel)

      //第2条数据
      let shopModel2: ShopInfo = JSON.parse(data.toString())
      //名字
      shopModel2.name = `风向：${shopModel.weatherinfo.WD}`
      //描述
      shopModel2.content = '今天风力比较大，不太适合出去玩呀'
      //图片
      shopModel2.image = 'https://upload-images.jianshu.io/upload_images/1521667-d1f70564b2a6c187?imageMogr2/auto-orient/strip%7CimageView2/2/w/640'
      this.shopArray.push(shopModel2)

    })
  }
}







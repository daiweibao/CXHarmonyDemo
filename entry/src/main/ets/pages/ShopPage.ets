
import { CXNavView } from '../CXComponents/CXNavComponent'
import ShopInfo from '../ViewModel/ShopInfo'
import ShopItem from '../Views/ShopItem'
import shopModel from '../model/ShopModel'
import promptAction from '@ohos.promptAction'



@Entry
@Component
struct ShopPage {
  @State shopArray: Array<ShopInfo> = []

  aboutToAppear(){
    //加载商品数据
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

  loadShopInfo(){
    // TODO 加载数据
    shopModel.getShopList()
    .then(data => {
      // let sho:ShopInfo = JSON.parse(data)
      let sho:ShopInfo =data
     // this.shopArray = shop

      let  ttt = sho.weatherinfo.weather

      console.log('控制器里请求结果：',JSON.stringify(data))

      promptAction.showToast({message:'数据请求结束'+JSON.parse(data)})

      console.log('控制器里请求结果weather：',ttt)
    })

    // let shops = [
    //   {
    //     id:6,
    //     name:'幸福里老北京刷肉火锅（鼓楼大街店）',
    //     content:'这是一家有百年历史的老北京火锅，大家喜欢的赶紧去吃',
    //     images:[
    //       'https://upload-images.jianshu.io/upload_images/1521667-aa76f7b8b3efec86.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/606',
    //       'https://upload-images.jianshu.io/upload_images/1521667-d1f70564b2a6c187?imageMogr2/auto-orient/strip%7CimageView2/2/w/640'
    //     ]
    //   },
    //   {
    //     id:7,
    //     name:'海底捞（北苑路店）',
    //     content:'这是一家连锁店火锅',
    //     images:[
    //       'https://upload-images.jianshu.io/upload_images/1521667-e7aac24d1ace30eb?imageMogr2/auto-orient/strip%7CimageView2/2/w/640',
    //       'https://upload-images.jianshu.io/upload_images/1521667-b5d6735aba47fa2b?imageMogr2/auto-orient/strip%7CimageView2/2/w/640'
    //     ]
    //   }
    // ]
    // this.shops = shops

  }

}







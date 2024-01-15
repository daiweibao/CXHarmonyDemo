
import ShopInfo from '../ViewModel/ShopInfo'

@Component
export default struct ShopItem {
  shop: ShopInfo
  build(){
    Column({space: 10}){
      //文本
      Text(this.shop.name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)

      Row({space:10}){
        //图片
        Image(this.shop.images[0])
          .width(100)
          .height(100)

        Text(this.shop.content)
          .fontSize(16)
          .fontColor(Color.Orange)
          .layoutWeight(1)
      }
      .alignItems(VerticalAlign.Top)
    }
    .alignItems(HorizontalAlign.Start)
    .margin({left:15,top:15,bottom:15,right:15})
  }
}

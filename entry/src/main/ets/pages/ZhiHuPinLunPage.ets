@Entry
@Component
struct ZhiHuPinLunPage {

  build() {
    Column () {
      HmNavBar()
      HmCommentItem()
    }
  }
}

@Component
struct HmNavBar {
  build() {
    Row(){
      Row() {
        Image($r("app.media.ic_public_back"))
          .width(16)
          .height(16)
          .fillColor('#848484')
      }
      .justifyContent(FlexAlign.Center)
      .width(24)
      .aspectRatio(1)
      .backgroundColor("#f5f5f5")
      .borderRadius(12)
      .margin({
        left: 15
      })
      Text("评论回复")
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(18)
        .padding({
          right: 39
        })
    }
    .height(40)
    .border({
      color: '#f4f4f4',
      width: {
        bottom: 0.5
      }
    })
  }
}

@Component
struct HmCommentItem {
  build() {
    Row() {
      // 左侧头像
      Image($r('app.media.chaoxiheader'))
        .width(32)
        .aspectRatio(1)
        .borderRadius(16)
      // 评论区
      Column({ space: 10 }) {
        Text("周杰伦")
          .fontWeight(FontWeight.Bold)
        Text("意大利拌面应该使用42号钢筋混凝土再加上量子力学缠绕最后通过不畏浮云遮望眼")
          .lineHeight(20)
          .fontSize(16)
          .fontColor('#565656')
        // 底部内容
        Row() {
          Text("10-12 .ip属地北京")
            .fontSize(12)
            .fontColor("#c3c4c5")
          Row() {
            Image($r("app.media.ic_public_favor"))
              .width(12)
              .aspectRatio(1)
              .fillColor('#c3c4c5')  // 填充颜色
              .margin({
                right: 5
              })
            Text("100")
              .fontSize(12)
              .fontColor("#c3c4c5")
          }
        }.justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({
        left: 10
      })
    }.padding(15)
    .alignItems(VerticalAlign.Top)
  }
}
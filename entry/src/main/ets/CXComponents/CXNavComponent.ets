@Component
//用export导出组件
export struct CXNavView {
  //导航栏标题
  private navTitle: ResourceStr
  build(){
    //标题
    Row() {
      Image($r('app.media.nav_back'))
        .width(30)
      Text(this.navTitle)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Blank()//空白组件
      Image($r('app.media.nav_refresh'))
        .width(30)
    }
    .width('100%')
    .height(30)
  }
}

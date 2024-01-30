import router from '@ohos.router'
@Component
//用export导出组件
export struct CXNavView {
  //导航栏标题
  private navTitle: ResourceStr

  @State params: Object = router.getParams()

  build(){
    //标题
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(30)
        .onClick(() => {
          //
          // //点击返回按钮时候，弹窗提示是否确定返回
          // router.showAlertBeforeBackPage({
          //   message: '确定要返回吗？'
          // })
          // //返回上级页面
          router.back()

          // //返回到指定页面并传值
          // router.back({
          //   url: 'pages/Index',
          //   params:{id: '10'}//传递的参数
          // })

        })

      if (this.navTitle){
        Text(this.navTitle)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({left:10})
      }
      Blank()//空白组件

      Image($r('app.media.ic_public_refresh'))
        .width(30)
        .onClick(()=>{
          //点击刷新
          
        })
    }
    .width('100%')
    .height(64)
    .padding({left:15,right:15})
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

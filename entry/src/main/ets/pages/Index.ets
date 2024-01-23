//程序入口，首页
//导入页面内跳转系统库
import router from '@ohos.router'

class RouterInfo {
  //页面内路径
  urlPage: string
  //页面标题
  title: string

  constructor(urlPage: string, title: string) {
    this.urlPage = urlPage;
    this.title = title
  }
}

@Entry
@Component
struct CXHomePage  {
  @State message: string = '页面列表'
  private routers: RouterInfo[] = [
    new RouterInfo('pages/CXImagePage','图片查看案例'),
    new RouterInfo('pages/MyZuJianPage','商品列表案例'),
    new RouterInfo('pages/CXPropPage','任务列表案例'),
    new RouterInfo('pages/AnimationPage','小鱼动画案例'),
    new RouterInfo('pages/LifeCirePage','生命周期案例1'),
    new RouterInfo('pages/TestPage1','生命周期案例2'),
    new RouterInfo('pages/DocumentListPage','多UIAbility跳转'),
    new RouterInfo('pages/WebTestPage','web页面'),
    new RouterInfo('pages/WebJiaoHuTestPage','web交互'),
    new RouterInfo('pages/HttpTestPage','网络请求'),
    new RouterInfo('pages/ShopPage','商铺列表'),
    new RouterInfo('pages/CXTestPage','测试'),
    new RouterInfo('pages/indexPage','测试2'),
    new RouterInfo('pages/Video/VideoTestPage','视频'),
    new RouterInfo('pages/PhotosPage','照片选择'),


  ]

  tag: string = 'Index Page'

  //页面即将出现时回调该接口
  aboutToAppear(){
    console.log(this.tag, 'about to appear')
  }
  //页面出现：页面每次显示时触发一次
  onPageShow(){
    console.log(this.tag, 'on page show')
  }
  //当用户点击手机【系统返回按钮】时触发
  onBackPress(){
    console.log(this.tag, 'on back press')
  }
  //页面隐藏：页面每次隐藏时触发一次
  onPageHide(){
    console.log(this.tag, 'on page hide')
  }
  //页面销毁之前执行
  aboutToDisappear(){
    console.log(this.tag, 'about to disappear')
  }




  build() {
    Column(){

      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .height(80)

      List({space: 15}){
        ForEach(
          this.routers,
          (router, index) => {
            ListItem(){
              this.RouterItem(router, index+1)
            }
          }
        )
      }
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  RouterItem(r: RouterInfo, i: number){
    Row(){
      Text(i + '.')
        .fontSize(20)
        .fontColor(Color.White)

      Blank()

      Text(r.title)
        .fontSize(20)
        .fontColor(Color.White)
    }
    .width('90%')
    .padding(12)
    .backgroundColor('#38f')
    .borderRadius(20)
    .shadow({radius: 6, color: '#4F000000', offsetX: 2, offsetY: 2})
    .onClick(() => {
      console.log(`点击了页面跳转：${r.urlPage}`)
      //点击，router页面内跳转，跳转到指定路径并传递参数
      router.pushUrl({
          url: r.urlPage,//页面跳转路径，如果新建的是ArkTS文件，需要在entry/src/main/resources/base/profile/main_pages.json文件中配置路由地址。如果新建的文件是page类型则会自动配置。
          params:{id: i}//传递的参数
        },
        router.RouterMode.Standard,//页面跳转模型，RouterMode枚举
        err => {//页面跳转异常回调函数
          if (err){
            //异常若误码：100001-内部者误，可能是渲染失改；100002-路出地址误；100003:-路由栈中页面超过32个。
            console.log(`路由失败.errCode:${err.code} errMsg:${err.message}`)
          }
        }
      )
    })
  }
}
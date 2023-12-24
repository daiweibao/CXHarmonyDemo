//入口文件演示代码
//Entry、Component 装饰器，用来装饰类结构、方法、变量
@Entry//标记当前组件是入口组件，其他地方可以调用
@Component//标记自定义组件
struct Index {//自定义组件：可复用的UI单元

  //@state：标记该变量是状态变量，值变化时会融发UI剧新
  @State message: string = 'Hello World'

  build() { //build是：UI描述，其内部以【声明式】方式描述UI工结构
    Row() { //行
      //下面UI组件有ArkUI提供
      //容器组件：用来完成页面布局，如：Row、Colum；基础组件：自带样式和功能的页面元素，如Text
      Column() { //列
        //声明一个文本
        Text(this.message)
          .fontSize(30) //字号
          .fontWeight(FontWeight.Bold) //字体粗细
          .fontColor('#36D') //颜色
          .onClick(() => { //点击事件
            //处理事件，如点击事件
            this.message = '点击了文本' //点击文本后页面UI会直接变化，自动刷新
          })
        //网络图片
        // Image('https://upload-images.jianshu.io/upload_images/1521667-4fa8c78d7b924a38.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1024')
        //本地图片
        Image($r('app.media.chaoxiheader'))
          .width(250)//单位vp，虚拟像素
          .interpolation(ImageInterpolation.High)
        //文本
        Text('我是文本')
          .lineHeight(32)//行高
          .fontSize(20)//字体大小
          .fontColor('#ff1876f8')//字体颜色
          .fontWeight(FontWeight.Medium)//字体粗细

      }
      .width('100%')

      // Row() {
      //     // Image($r('app.media.chaoxiheader')) //本地图片路径
      //   Image('https://upload-images.jianshu.io/upload_images/1521667-4fa8c78d7b924a38.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1024')
      //     .width(100) //宽度
      //     .height(100) //高度
      //     .borderRadius(10) //边框圆角
      //     .interpolation(ImageInterpolation.High) //图片插值
      // }.height('30%')

    }
    .height('100%')
  }
}

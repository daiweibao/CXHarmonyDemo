// xxx.ets
import web_webview from '@ohos.web.webview';
//拨打电话框架导入
import call from '@ohos.telephony.call';

@Entry
@Component
struct WebComponent {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();

  build() {
    Column() {
      Web({ src: $rawfile('local.html'), controller: this.webviewController})
        .onUrlLoadIntercept((event) => {
          let url: string = event.data as string;
          // 判断链接是否为拨号链接
          if (url.indexOf('tel://') === 0) {
            // 跳转拨号界面
            call.makeCall(url.substring(6), (err) => {
              if (!err) {
                console.info('拨号成功');
              } else {
                console.info('拨号失败:' + JSON.stringify(err));
              }
            });
            return true;
          }
          //获取当前网页的标题。
          this.webviewController.getTitle()
          //获取网页高度
          let pageHeight = this.webviewController.getPageHeight();

          return false;
        })
        .onPageBegin((event)=> {
           //网页开始加载：event.url
        })
        .onPageEnd((event)=> {
          //网页结束加载：event.url
        })
        .onProgressChange((event) => {
          //网页加载进度条进度值获取
          console.log('newProgress:' + event.newProgress)
        })
        .onUrlLoadIntercept((event) => {
          //当Web组件加载url之前触发该回调，用于判断是否阻止此次访问。默认允许加载。
          console.log('onUrlLoadIntercept ' + event.data.toString())
          //返回true表示阻止此次加载，否则允许此次加载。
          return true
        })
        .onScroll((event) => {
          //通知网页滚动条滚动位置。
          console.info("x = " + event.xOffset)
          console.info("y = " + event.yOffset)
        })
    }
  }
}

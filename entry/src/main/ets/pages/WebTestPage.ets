// xxx.ets
import web_webview from '@ohos.web.webview';

@Entry
@Component
struct WebComponent {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  build() {
    Column() {
      Button('loadData')
        .onClick(() => {
          //如果存在历史记录，accessBackward()接口会返回true;同样，您可以使用accessForward()接口检查是否存在前进的历史记录。如果您不执行检查，那么当用户浏览到历史记录的末尾时，调用forward()和backward()接口时将不执行任何操作。
          if (this.webviewController.accessBackward()) {
            this.webviewController.backward();//返回
            return true;
          }
        })
      Web({ src: 'https://www.example.com/cn/', controller: this.webviewController})
    }
  }
}

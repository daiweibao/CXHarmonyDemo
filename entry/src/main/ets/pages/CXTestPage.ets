// xxx.ets
import web_webview from '@ohos.web.webview'

@Entry
@Component
struct WebComponent {
  controller: web_webview.WebviewController = new web_webview.WebviewController();
  ports: web_webview.WebMessagePort[];

  build() {
    Column() {
      Button('createWebMessagePorts')
        .onClick(() => {
          try {
            this.ports = this.controller.createWebMessagePorts();
            console.log("createWebMessagePorts size:" + this.ports.length)
          } catch (error) {
            console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
          }
        })
      Web({ src: 'www.example.com', controller: this.controller })
    }
  }
}

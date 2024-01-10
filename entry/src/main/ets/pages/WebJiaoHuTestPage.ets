// xxx.ets
import web_webview from '@ohos.web.webview';

@Entry
@Component
struct WebComponent {
  //Web控制器
  controller: web_webview.WebviewController = new web_webview.WebviewController();
  //声明消息通讯接口：通过WebMessagePort可以进行消息的发送以及接收。
  ports: web_webview.WebMessagePort[];

  //UI展示用
  @State sendFromEts: string = '将此消息从ets发送到HTML';
  @State receivedFromHtml: string = '显示从HTML发送的接收消息';

  build() {
    Column({space:10}) {
      // 展示接收到的来自HTML的内容
      Text(this.receivedFromHtml)
      // 输入框的内容发送到html
      TextInput({placeholder: '将此消息从ets发送到HTML'})
        .onChange((value: string) => {
          this.sendFromEts = value;
        })

      Button('postMessage')
        .onClick(() => {

          // 1、创建两个消息端口，实现与H5通讯；此方法会创建2个端口。一个客户端用，一个H5用。
          this.ports = this.controller.createWebMessagePorts();
          // 2、在应用侧的消息端口(如端口1)上注册回调事件，接收HTML5侧发送过来的消息
          this.ports[1].onMessageEvent((result: web_webview.WebMessage) => {
            //接收H5给App发的消息
            //WebMessage接收到的消息，string：字符串类型数据。ArrayBuffer：二进制类型数据。
            let msg = '从HTML中获取msg:';
            if (typeof(result) === 'string') {
              //字符串类型
              console.info(`从html5收到的字符串消息，字符串是: ${result}`);
              msg = msg + result;

            } else if (typeof(result) === 'object') {
              //对象类型
              if (result instanceof ArrayBuffer) {
                //二进制类型数据。
                console.info(`received arraybuffer from html5, length is: ${result.byteLength}`);
                msg = msg + '长度是 ' + result.byteLength;
              } else {
                console.info('不支持');
              }
            } else {
              //不支持的类型
              console.info('不支持');
            }
            this.receivedFromHtml = msg;
          })
          // 3、将另一个消息端口(如端口0)发送到HTML侧，由HTML侧保存并使用。
          this.controller.postMessage('__init_port__', [this.ports[0]], '*');
        })

      // 4、使用应用侧的端口给另一个已经发送到html的端口发送消息。
      Button('发消息到H5')
        .onClick(() => {
          if (this.ports && this.ports[1]) {//判空
            //通过端口1，发消息给H5；WebMessage类型
            this.ports[1].postMessageEvent(this.sendFromEts);
          } else {
            console.error(`ports is null, Please initialize first`);
          }
        })
      Web({ src: $rawfile('local.html'), controller: this.controller })
    }
  }
}


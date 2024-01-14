
// 网络请求：引入包名
import http from '@ohos.net.http';
import { CXNavView } from '../CXComponents/CXNavComponent';

@Entry
@Component
struct HttpTestPage {
  @State message: string = '发起网络请求'
  //天气接口（GET）： http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?

  public urlWeatherapi: string = 'http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?'

  build() {
    Row() {
      Column() {
        CXNavView()
        Image('https://upload-images.jianshu.io/upload_images/1521667-2351b84d1b52dcbc.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/640')
          .height(100)
          .width(200)
          .backgroundColor(Color.Red)
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            this.loadData()
          })
      }
      .width('100%')
    }
    .height('100%')
  }


  //网络请求
  loadData(){
    // 每一个httpRequest对应一个HTTP请求任务，不可复用
    let httpRequest = http.createHttp();
    httpRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      this.urlWeatherapi,
      {
        method: http.RequestMethod.GET, // 请求方式。可选，默认为http.RequestMethod.GET
        // HTTP请求头字段。默认{'Content-Type': 'application/json'}。开发者根据自身业务需要添加header字段。
        header: {
          'Content-Type': 'application/json'
        },
        // 请求参数；当使用POST请求时此字段用于传递
        extraData: {
          "cityId": "101040100",
        },
        expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
        usingCache: true, // 是否使用缓存。可选，默认为true
        priority: 1, // 优先级，范围[1,1000]。可选，默认为1
        connectTimeout: 60000, //连接超时时间。可选，默认为60000ms
        readTimeout: 60000, // 读取超时时间。可选，默认为60000ms
        usingProtocol: http.HttpProtocol.HTTP1_1, //使用协议。可选，协议类型默认值由系统自动指定
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('Result:' + JSON.stringify(data.result));
        console.info('code:' + JSON.stringify(data.responseCode));
        // data.header为HTTP响应头，可根据业务需要进行解析
        console.info('header:' + JSON.stringify(data.header));
        console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁
        httpRequest.destroy();
      } else {
        console.info('error:' + JSON.stringify(err));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    }
    );
  }
}



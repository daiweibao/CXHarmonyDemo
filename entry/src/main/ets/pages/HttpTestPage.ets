
// 网络请求：引入包名
import http from '@ohos.net.http';
import { CXNavView } from '../CXComponents/CXNavComponent';

@Entry
@Component
struct HttpTestPage {
  //请求接口：天气接口（GET）： http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?
  public pathUrl: string = 'http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?'
  //请求参数
  public parmDict = {
    "cityId": "101040100"//城市Id
  }

  build() {
    Column({space:20}) {
      CXNavView()//导航栏
      Text('发起网络请求')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .onClick(()=>{
          //点击发起网络请求
          this.loadData()
        })
    }
    .justifyContent(FlexAlign.Start)
    .height('100%')
  }

  //网络请求
  loadData(){
    // 每一个httpRequest对应一个HTTP请求任务，不可复用
    let httpRequest = http.createHttp();
    httpRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      this.pathUrl,
      {
        method: http.RequestMethod.GET, // 请求方式。可选，默认为http.RequestMethod.GET
        // HTTP请求头字段。默认{'Content-Type': 'application/json'}。开发者根据自身业务需要添加header字段。
        header: {
          'Content-Type': 'application/json'
        },
        // 请求参数；当使用POST请求时此字段用于传递
        extraData: this.parmDict,
        expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
        usingCache: true, // 是否使用缓存。可选，默认为true
        priority: 1, // 优先级，范围[1,1000]。可选，默认为1
        connectTimeout: 60000, //连接超时时间。可选，默认为60000ms
        readTimeout: 60000, // 读取超时时间。可选，默认为60000ms
        usingProtocol: http.HttpProtocol.HTTP1_1, //使用协议。可选，协议类型默认值由系统自动指定
      }, (err, data) => {
      //请求结果处理
      if (!err) {
        //请求成功，responseCode：200
        console.info('状态码:' + JSON.stringify(data.responseCode));
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('请求结果:' + JSON.stringify(data.result));
        // 请求结果:"{\"weatherinfo\":{\"SD\":\"92%\",\"WD\":\"东北偏北风\",\"WS\":\"2级\",\"WSE\":\"\",\"city\":\"\",\"cityid\":\"101040100\",\"isRadar\":\"1\",\"radar\":\"JC_RADAR_AZ9010_JB\",\"temp\":\"13\",\"time\":\"09:30\",\"weather\":\"多云\"}}"

        console.info('请求结果2：',JSON.parse(data.result.toString()))

        let dictDtat: weatherinfoClass = data.result as weatherinfoClass
        // let nameStr = dictDtat['weatherinfo']
        console.info('天气数据：',dictDtat.weatherinfo)
        console.info('map数据：',dictDtat)




        // data.header为HTTP响应头，可根据业务需要进行解析
        console.info('请求头header:' + JSON.stringify(data.header));
        console.info('cookies:' + JSON.stringify(data.cookies)); // 8+

        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁
        httpRequest.destroy();
      } else {
        //请求失败
        console.info('error:' + JSON.stringify(err));

        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    });
  }
}

class weatherinfoClass {
  public  weatherinfo: object
  constructor(weatherinfo:any) {
    this.weatherinfo = weatherinfo
  }
}






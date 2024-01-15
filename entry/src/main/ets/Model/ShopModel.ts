import http from '@ohos.net.http';
import ShopInfo from '../ViewModel/ShopInfo';
class ShopModel {

  //请求接口：天气接口（GET）： http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?
  public pathUrl: string = 'http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?'
  //请求参数
  public parmDict = {
    "cityId": "101040100"//城市Id
  }

  getShopList(): Promise<ShopInfo[]> {
    //resonlve是成功的通知，reject是失败的通知
    return new Promise((resonlve, reject) => {

      //创建网络请求
      let httpRequest = http.createHttp();
      httpRequest.request(
        // 填写HTTP请求的URL地址
        this.pathUrl,
        {
          method: http.RequestMethod.GET, // 请求方式。
          // HTTP请求头字段。
          header: {
            'Content-Type': 'application/json'
          },
          // 请求参数
          extraData: this.parmDict,
        }, (err, data) => {
        //请求结果处理
        if (!err) {
          //请求成功，responseCode：200
          console.info('状态码:' + JSON.stringify(data.responseCode));
          // data.result为HTTP响应内容，可根据业务需要进行解析
          console.info('请求结果:' + JSON.stringify(data.result));

          if (data.responseCode === 200) {
            // 请求结果:"{\"weatherinfo\":{\"SD\":\"92%\",\"WD\":\"东北偏北风\",\"WS\":\"2级\",\"WSE\":\"\",\"city\":\"\",\"cityid\":\"101040100\",\"isRadar\":\"1\",\"radar\":\"JC_RADAR_AZ9010_JB\",\"temp\":\"13\",\"time\":\"09:30\",\"weather\":\"多云\"}}"
            //json字符串转对象
            //成功后异步回调
            resonlve(JSON.parse(data.result.toString()))
            console.info('数据请求成功')

          }else {
            //失败：对象转json字符串
            console.info('error:' + JSON.stringify(data))
            reject('数据请求失败')
          }

          // 当该请求使用完毕时，调用destroy方法主动销毁
          httpRequest.destroy()
        } else {
          //请求失败
          console.info('error:' + JSON.stringify(err))

          reject('数据请求失败')

          // 当该请求使用完毕时，调用destroy方法主动销毁。
          httpRequest.destroy();
        }
      })
    })
  }
}

const shopModel = new ShopModel()

export default shopModel as ShopModel
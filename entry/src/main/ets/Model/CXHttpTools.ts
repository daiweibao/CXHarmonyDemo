import http from '@ohos.net.http';
import promptAction from '@ohos.promptAction';
class CXHttpTools {
  //请求接口：天气接口（GET）： http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?
  //请求参数：cityId  101040100  城市Id
  // 请求结果:"{\"weatherinfo\":{\"SD\":\"92%\",\"WD\":\"东北偏北风\",\"WS\":\"2级\",\"WSE\":\"\",\"city\":\"\",\"cityid\":\"101040100\",\"isRadar\":\"1\",\"radar\":\"JC_RADAR_AZ9010_JB\",\"temp\":\"13\",\"time\":\"09:30\",\"weather\":\"多云\"}}"

  // postWithURL(): Promise<any> {
  postWithURL(pathUrl: string, para: Object): Promise<any>{
    //resonlve是成功的通知，reject是失败的通知
    return new Promise((resonlve, reject) => {
      //创建网络请求
      let httpRequest = http.createHttp();
      httpRequest.request(
        //填写HTTP请求的URL地址
        pathUrl,
        {
          method: http.RequestMethod.GET, // 请求方式。
          // HTTP请求头字段。
          header: {
            'Content-Type': 'application/json'
          },
          // 请求参数
          extraData: para,
          connectTimeout: 60000, //连接超时时间。可选，默认为60000ms
        }, (err, data) => {
        //请求结果处理
        if (!err) {
          //请求成功，responseCode：200
          if (data.responseCode === 200) {
            // data.result为HTTP响应内容，可根据业务需要进行解析
            console.info('网络请求成功：' + JSON.stringify(data.result));
            //成功后异步回调
            resonlve(data.result)
          }else {
            //失败：对象转json字符串
            console.info('网络请求失败：' + JSON.stringify(data))
            reject('网络请求失败')
            promptAction.showToast({message:'网络请求失败，错误码：'+`${data.responseCode}`})
          }
          // 当该请求使用完毕时，调用destroy方法主动销毁
          httpRequest.destroy()

        } else {
          //请求失败
          console.info('网络请求失败：' + JSON.stringify(err))
          reject('网络请求失败')
          // 当该请求使用完毕时，调用destroy方法主动销毁。
          httpRequest.destroy();
        }
      })
    })
  }
}

//初始化网络请求工具类，用const修饰，表示只初始化一次
const httpTools = new CXHttpTools()
// as：用于重命名输出和输入接口。
export default httpTools as CXHttpTools




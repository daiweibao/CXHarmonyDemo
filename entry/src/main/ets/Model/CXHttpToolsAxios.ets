import axios from '@ohos/axios'//导入头axios文件
class CXHttpToolsAxios {
  //请求接口：天气接口（GET）： http://weatherapi.market.xiaomi.com/wtr-v2/temp/realtime?
  //请求参数：cityId  101040100  城市Id
  // 请求结果:"{\"weatherinfo\":{\"SD\":\"92%\",\"WD\":\"东北偏北风\",\"WS\":\"2级\",\"WSE\":\"\",\"city\":\"\",\"cityid\":\"101040100\",\"isRadar\":\"1\",\"radar\":\"JC_RADAR_AZ9010_JB\",\"temp\":\"13\",\"time\":\"09:30\",\"weather\":\"多云\"}}"

  // postWithURL(): Promise<any> {
  postWithURL(pathUrl: string, para: Object): Promise<any>{
    //resonlve是成功的通知，reject是失败的通知
    return new Promise((resonlve, reject) => {
      console.log('=========发起网络请求============')
      //创建网络请求
      //方式一
      axios({
        url: pathUrl,//网络请求接口
        params: para,//get方式网络请求参数
        method: 'get',//请求方式
        timeout: 60000, //连接超时时间，单位毫秒
        headers: {// HTTP请求头字段。
          'Content-Type': 'application/json'
        },
      }).then(response => {
        if (response.status === 200) {
          console.log('请求成功：',JSON.stringify(response.data))
          resonlve(JSON.stringify(response.data))//返回string类型
        }else {
          console.log('业务请求失败：', JSON.stringify(response.data))
          reject('业务请求失败')
        }
      }).catch(error => {
        console.log('数据请求失败，error：',JSON.stringify(error))
        reject('网络请求失败error')
      })
      //方式二
      // axios.get(
      //   pathUrl,//网络请求接口
      //   {
      //     params: para//get方式网络请求参数
      //   },
      // ).then(response => {
      //   if (response.status === 200) {
      //     console.log('请求成功：',JSON.stringify(response.data))
      //     resonlve(JSON.stringify(response.data))//返回string类型
      //   }else {
      //     console.log('业务请求失败：', JSON.stringify(response.data))
      //     reject('业务请求失败')
      //   }
      // }).catch(error => {
      //   console.log('数据请求失败，error：',JSON.stringify(error))
      //   reject('网络请求失败error')
      // })
    })
  }
}

//初始化网络请求工具类，用const修饰，表示只初始化一次
const httpToolsAxios = new CXHttpToolsAxios()
// as：用于重命名输出和输入接口。
export default httpToolsAxios as CXHttpToolsAxios




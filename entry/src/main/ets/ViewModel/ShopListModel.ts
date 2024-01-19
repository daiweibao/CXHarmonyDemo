//数据模型
export default class ShopListModel {
  //id
  id: number
  //标题
  name: string = ''
  //描述
  content: string = ''
  //图片
  image: string = ''
  //接口字段
  weatherinfo: weatherinfo
}
class weatherinfo{
  //风向
  WD:string = ''
  //天气
  weather:string = ''
}

// 请求结果:"{\"weatherinfo\":{\"SD\":\"92%\",\"WD\":\"东北偏北风\",\"WS\":\"2级\",\"WSE\":\"\",\"city\":\"\",\"cityid\":\"101040100\",\"isRadar\":\"1\",\"radar\":\"JC_RADAR_AZ9010_JB\",\"temp\":\"13\",\"time\":\"09:30\",\"weather\":\"多云\"}}"

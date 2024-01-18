
export default class ShopInfo {
  id: number
  name: string = ''
  content: string = ''
  image: string = ''

  //接口字段
  weatherinfo: weatherinfo
}
class weatherinfo{
  WD:string = ''
  weather:string = ''
}

// 请求结果:"{\"weatherinfo\":{\"SD\":\"92%\",\"WD\":\"东北偏北风\",\"WS\":\"2级\",\"WSE\":\"\",\"city\":\"\",\"cityid\":\"101040100\",\"isRadar\":\"1\",\"radar\":\"JC_RADAR_AZ9010_JB\",\"temp\":\"13\",\"time\":\"09:30\",\"weather\":\"多云\"}}"

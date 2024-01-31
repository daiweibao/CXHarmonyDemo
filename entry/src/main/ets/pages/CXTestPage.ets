// xxx.ets
//导入自定义用户首选项模块
import PreferencesUtil from '../common/Utils/PreferencesUtil'
@Entry
@Component
struct TextTimerExample {
  //TextTimer控制器，一个TextTimer组件仅支持绑定一个控制器。
  textTimerController: TextTimerController = new TextTimerController()
  @State format: string = 'mm:ss.SS'

  @State fontSize: number = 16

  async aboutToAppear(){
    //读取：后面是默认值
    this.fontSize = await PreferencesUtil.getPreferenceValue('IndexFontsize', 16) as number
  }

  build() {
    Column() {
      //isCountDown：是否倒计时,默认值：false
      //count：倒计时时间（isCountDown为true时生效），单位为毫秒。
      // 最长不超过86400000毫秒（24小时）。 0<count<86400000时，count值为倒计时初始值。否则，使用默认值为倒计时初始值。默认值：60000
      TextTimer({ isCountDown: false, count: 30000, controller: this.textTimerController })
        .format(this.format)//format：自定义格式，需至少包含一个HH、mm、ss、SS中的关键字。如使用yy、MM、dd等日期格式，则使用默认值。默认值：'HH:mm:ss.SS'
        .fontColor(Color.Black)
        .fontSize(50)
        .onTimer((utc: number, elapsedTime: number) => {
          //时间文本发生变化时触发。
          // utc：Linux时间戳，即自1970年1月1日起经过的毫秒数。
          // elapsedTime：计时器经过的时间，单位为毫秒。
          console.info('textTimer 时间戳 utc is：' + utc + ', 计时器经过的时间: ' + elapsedTime)
        })
      Row() {
        Button("计时器开始").onClick(() => {
          //计时开始。
          this.textTimerController.start()
        })
        Button("计时器暂停").onClick(() => {
          //计时暂停。
          this.textTimerController.pause()
        })
        Button("计时器重置").onClick(() => {
          //重置计时器。
          this.textTimerController.reset()

          //写入数据
          PreferencesUtil.putPreferenceValue('IndexFontsize', 20)

        })
      }
    }
  }
}

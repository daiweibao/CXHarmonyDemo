import NotificationManager from '@ohos.notificationManager';//推送通知模块@Entry
import wantAgent from '@ohos.app.ability.wantAgent';//推送通知的行为意图
import common from '@ohos.app.ability.common';//上下文模块

@Entry
@Component
struct NotificationTest1 {
  //上下文
  private context = getContext(this) as common.UIAbilityContext;
  //通知跳转意图
  private wantAgentObj = null;
  //生命周期
  aboutToAppear(){
    //创建一个wantAgentInfo对象
    let bundleName = this.context.abilityInfo.bundleName;//应用包名
    let abilityName = this.context.abilityInfo.name;//应用名字
    let  wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: bundleName,//应用包名
          abilityName: abilityName,//应用名字
          uri:"pages/FlexTestPage",//页面跳转路径
          parameters:{},//页面跳转参数
        }
      ],
      operationType: wantAgent.OperationType.START_ABILITY,//START_ABILITY：开启一个有页面的Ability
      requestCode: 100,//使用者定义的一个私有值。比如100代表成功
      wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG],//CONSTANT_FLAG：WantAgent是不可变的。
    }

    //创建WantAgent对象，发通知的时候传给wantAgent参数
    wantAgent.getWantAgent(wantAgentInfo)
      .then((data) => {
        this.wantAgentObj = data;
      })
      .catch((err) => {
        console.error(`wantAgent对象创建失败 ${JSON.stringify(err)}`);
      })
  }

  //发送通知
  senderNotification(){
    //创建通知
    let notificationRequest: NotificationManager.NotificationRequest = {
      id: 13214,//通知ID，用来清除通知用
      slotType: NotificationManager.SlotType.SOCIAL_COMMUNICATION,//通知通道类型--社交类
      content: {
        contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知：NOTIFICATION_CONTENT_BASIC_TEXT
        normal: {
          title: '我是标题',//通知标题
          text: '我是内容文本',//通知内容
          additionalText: '我是通知的附加内容',//通知附加内容，是对通知内容的补充。显示在App名字后面
        }
      },
      deliveryTime: new Date().getTime(),//发送通知的时间，当前系统时间
      showDeliveryTime: true,//是否展示通知时间
      groupName: 'wechat',//通知分组，分组名字相同的通知会在一个分组里
      wantAgent: this.wantAgentObj//添加通知行为意图，如点击通知打开指定页面
    }
    //发送通知
    NotificationManager.publish(notificationRequest, (err) => {
      if (err) {
        console.error(`通知发送失败：[${err}]`);
        return;
      }
      console.info('通知发送成功');
    });
  }

  build() {
    Column() {
      Button('发送通知').onClick((event: ClickEvent) => {
        this.senderNotification()
      })
    }
    .width('100%')
  }
}

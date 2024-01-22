import notification from '@ohos.notificationManager';//通知模块
import image from '@ohos.multimedia.image';//图片处理模块

@Entry
@Component
struct NotificationTest1 {

  //得到pixelMap格式图片
  async get_pixelmap(){
    // 获取resourceManager资源管理
    const context = getContext(this)
    const resourceMgr = context.resourceManager
    // 获取media文件夹下的watchGT4.png图片
    const fileData = await resourceMgr.getMediaContent($r('app.media.watchGT4'))
    const buffer = fileData.buffer
    // 创建imageSource
    const imageSource = image.createImageSource(buffer)
    // 创建PixelMap
    const pixelMap = await imageSource.createPixelMap()
    return pixelMap
  }

  //发送图片通知
  async publishPictureNotification() {
    //异步获取PixelMap格式的图片
    let pixelMap = await this.get_pixelmap()

    let notificationRequest: notification.NotificationRequest = { // 描述通知的请求
      id: 1,
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_PICTURE,//图片类型通知
        picture: {
          title: '好物热销中', // 通知内容标题
          text: '展开查看详情', // 通知内容
          expandedTitle: '今日热门推荐', // 通知展开时的内容标题
          briefText: '这里一定有您喜欢的', // 通知概要内容，是对通知内容的总结
          picture: pixelMap // 通知的图片内容
        }
      }
    }
    notification.publish(notificationRequest).then(() => { // 发布通知
      console.info('推送成功');
    }).catch((err) => {
      console.error(`推送失败:${err.code}, message:${err.message}`);
    });
  }

  build() {
    Column() {
      Button('发送大图通知')
        .onClick(() => {
          this.publishPictureNotification()

        })
    }
    .width('100%')
  }
}



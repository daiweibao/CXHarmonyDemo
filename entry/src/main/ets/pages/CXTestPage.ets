import NotificationManager from '@ohos.notificationManager';//推送通知模块

import image from '@ohos.multimedia.image';//全局导入Image模块。

import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct FocusableExample {

  @State message: string = ''

  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text(this.message)
        // $r('app.media.chaoxiheader')
        Button('发布通知').onClick(async  (event: ClickEvent) => {
          const context = getContext(this);
          // 获取resourceManager资源管理
          const resourceMgr = context.resourceManager;
          const fileData = await resourceMgr.getRawFileContent('chaoxiimage.png');
          // 获取图片的ArrayBuffer
          const buffer = fileData.buffer;

          console.log('图片地址：'+fileData)


          promptAction.showToast({message:`${fileData.toString()}`})




          // let imagePixelMap: PixelMap = undefined; // 需要获取图片PixelMap信息
          // let notificationRequest = {
          //   id: 1,
          //   content: {
          //     contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,//图片类型通知
          //     picture: {
          //       title: '我是通知标题',//通知标题
          //       text: '我是通知内容',//通知内容
          //       additionalText: '通知附加内容',//通知附加内容，是对通知内容的补充。
          //       briefText: '通知概要内容',//通知概要内容，是对通知内容的总结。
          //       expandedTitle: '通知展开时的标题',//通知展开时的标题。
          //       picture: imagePixelMap//通知的图片内容
          //     }
          //   }
          // };
          //
          // // 发布通知
          // NotificationManager.publish(notificationRequest, (err) => {
          //   if (err) {
          //     console.error(`Failed to publish notification. Code is ${err.code}, message is ${err.message}`);
          //     return;
          //   }
          //   console.info('图片通知发送成功');
          // });








        })





      }.alignItems(HorizontalAlign.Center)
    }
  }
}
// xxx.ets
@Entry
@Component
struct WebComponent {
  controller:WebController = new WebController();
  build() {
    Column() {
      Web({ src:$rawfile('local.html'), controller:this.controller })
        .onConfirm((event) => {//网页警告弹窗事件
          AlertDialog.show({
            title: '标题',
            message: event.message,//消息
            confirm: {
              value: 'onAlert',
              action: () => {
                //如果确认对话框，处理用户的JavaScript结果
                event.result.handleConfirm();
              }
            },
            cancel: () => {
              //如果取消对话框，处理用户的JavaScript结果
              event.result.handleCancel();
            }
          })
          //当onConfirm回调返回false时，触发默认弹窗。当回调返回true时，系统应用可以调用系统弹窗能力（包括确认和取消），并且需要根据用户的确认或取消操作调用JsResult通知Web组件。
          return true;
        })
    }
  }
}
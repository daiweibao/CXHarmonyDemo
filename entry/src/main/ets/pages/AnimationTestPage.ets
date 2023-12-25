
//属性动画
// @Entry
@Component
struct IndexShuXin {
  @State widthSize: number = 250
  @State heightSize: number = 100
  @State flag: boolean = true

  build() {
    Column() {
      Button('开始动画')
        .onClick(() => {
          if (this.flag) {
            //按钮变小
            this.widthSize = 150
            this.heightSize = 60
          } else {
            //按钮变打大
            this.widthSize = 250
            this.heightSize = 100
          }
          //状态切换
          this.flag = !this.flag
        })
        .margin(30)
        .width(this.widthSize)
        .height(this.heightSize)
        .animation({
          duration: 2000,
          curve: Curve.EaseOut,
          iterations: 3,
          playMode: PlayMode.Normal
        })
    }
    .width('100%')
    .margin({ top: 20 })
  }
}



//显式动画
// @Entry
@Component
struct IndexXianShi {
  @State widthSize: number = 250
  @State heightSize: number = 100
  private flag: boolean = true

  build() {
    Column() {
      Button('改变大小')
        .width(this.widthSize)
        .height(this.heightSize)
        .margin(30)
        .onClick(() => {
          if (this.flag) {
            //按钮变小
            animateTo({}, () => {
              this.widthSize = 150
              this.heightSize = 60
            })
          } else {
            //按钮变大
            animateTo({}, () => {
              this.widthSize = 250
              this.heightSize = 100
            })
          }
          //切换
          this.flag = !this.flag
        })
    }
    .width('100%')
    .margin({ top: 5 })
  }
}

//组件转场动画：
@Entry
@Component
struct Index {
  @State flag: boolean = true

  build() {
    Column() {
      Button(this.flag ? '隐藏组件' : '展示组件')
        .margin(30)
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            //动画结束后改变状态，重新渲染UI
            this.flag = !this.flag
          })
        })
      if (this.flag) {
        //创建图片
        Image($r('app.media.icon'))
          .width(300)
          .height(300)
          //展示图片控件的动画：左右翻转后展示
          .transition({ type: TransitionType.Insert, scale: { x: 0, y: 1.0 } })
          //隐藏图片控件的动画：顺时针旋转180度后移除
          .transition({ type: TransitionType.Delete, rotate: { angle: 180 } })
      }else {
        //不创建图片控件
      }
    }
    .width('100%')
  }
}







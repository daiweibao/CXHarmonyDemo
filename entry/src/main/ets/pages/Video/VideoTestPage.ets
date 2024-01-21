import App from '@system.app'
// @Entry
@Component
struct VideoTestPage {
  private controller:VideoController;
  private previewUris: Resource = $r ('app.media.chaoxiheader');
  private innerResource: Resource = $rawfile('chaoxishipin.mp4');//$rawfile()
  build() {
    Column() {
      Video({
        src:this.innerResource,//视频文件
        previewUri:this.previewUris,//视频封面图
        controller:this.controller//视频控制器
      })
        .width('100%')
        .height('100%')
    }
      .width('100%')
  }
}
// @Entry
@Component
export struct VideoPlayer{
  private controller:VideoController;//视频控制器
  private previewUris: Resource = $r ('app.media.chaoxiheader');//视频封面图
  private videoSrc: string= 'https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4'//网络视频地址
  build(){
    Column() {
      Video({
        src: this.videoSrc,
        previewUri: this.previewUris,
        controller: this.controller
      })


      Video({
        controller: this.controller
      })
        .muted(false) //设置是否静音
        .controls(false) //设置是否显示默认控制条
        .autoPlay(false) //设置是否自动播放
        .loop(false) //设置是否循环播放
        .objectFit(ImageFit.Contain) //设置视频适配模式


      Video({
        controller: this.controller
      })
        .onStart(() => {//播放时触发该事件。
          console.info('开始播放')
        })
        .onPause(() => {//暂停时触发该事件。
          console.info('暂停播放')
        })
        .onFinish(() => {//播放结束时触发该事件。
          console.info('播放完成')
        })
        .onError(() => {//失败事件回调
          console.info('播放失败')
        })
        .onPrepared((e) => {//视频准备完成时触发该事件。duration：当前视频的时长，单位为秒(s)。
          console.info('视频准备完成，总时长： ' + e.duration)
        })
        .onSeeking((e) => {//操作进度条过程时上报时间信息。time：当前视频播放的进度，单位为s。
          console.info('操作进度条，时间进度：' + e.time)
        })
        .onSeeked((e) => {//操作进度条完成后，上报播放时间信息。time：当前视频播放的进度，单位为s。
          console.info('操作进度条完成，时间进度：' + e.time)
        })
        .onUpdate((event) => {//播放进度变化时触发该事件。time：当前视频播放的进度，单位为s。
          console.info("播放进度变化");
        })
        .onFullscreenChange((e) => {
          //在全屏播放与非全屏播放状态之间切换时触发该事件。
          // fullscreen：返回值为true表示进入全屏播放状态，为false则表示非全屏播放。
          console.info('视频进入和退出全屏时触发该事件：' + e.fullscreen)
        })
    }
  }
}


//自定义视频播放器
@Entry
@Component
struct VideoGuide {
  controller: VideoController = new VideoController()//自定义视频播放器控制器
  @State videoSrc: Resource = $rawfile('chaoxishipin.mp4')//视频地址
  @State previewUri: Resource = $r ('app.media.chaoxiheader');//视频封面地址
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X//视频播放倍速
  @State showControls: boolean = true//是否显示视频控制栏
  @State currentTime: number = 0;//播放进度时间
  @State durationTime: number = 0;//视频总时长

  build() {
    Row() {
      Column() {
        Video({
          src: this.videoSrc,//视频地址
          previewUri: this.previewUri,//视频封面
          currentProgressRate: this.curRate,//视频播放倍速
          controller: this.controller//控制器
        })
          .controls(false)//设置是否显示默认控制条
          .autoPlay(true)//设置是否自动播放
          .onPrepared((event)=>{
            //视频准备完成，回调这里
            this.durationTime = event.duration
          })
          .onUpdate((event)=>{
            ////播放进度变化时触发该事件。time：当前视频播放的进度，单位为s。
            this.currentTime =event.time
          })

        //自定义UI
        Row() {
          Text(JSON.stringify(this.currentTime) + 's').width(40)//当前播放进度时长UI
          Slider({//视频播放滑块UI
            value: this.currentTime,//当前进度
            min: 0,//最小值
            max: this.durationTime//总长度
          })
            .layoutWeight(1)
            .onChange((value: number, mode: SliderChangeMode) => {
              //进度条改变
              this.controller.setCurrentTime(value);
            })
          Text(JSON.stringify(this.durationTime) + 's').width(40)//总时长UI
        }
        .opacity(0.8)//透明度
        .width("100%")

        Row() {
          Button('切换视频').onClick(() => {
            this.videoSrc = $rawfile('chaoxishipin.mp4') // 切换视频源
          }).margin(5)
          Button('切换视频封面').onClick(() => {
            this.previewUri = $r('app.media.app_icon') // 切换视频预览海报
          }).margin(5)
          Button('是否展示控制栏').onClick(() => {
            this.showControls = !this.showControls // 切换是否显示视频控制栏
          }).margin(5)
        }.width('100%')

        Row() {
          Button('开始播放').onClick(() => {
            this.controller.start() // 开始播放
          }).margin(5)
          Button('暂停播放').onClick(() => {
            this.controller.pause() // 暂停播放
          }).margin(5)
          Button('停止播放').onClick(() => {
            this.controller.stop() // 结束播放
          }).margin(5)
          Button('跳转到指定位置').onClick(() => {
            this.controller.setCurrentTime(10, SeekMode.Accurate) // 精准跳转到视频的10s位置
          }).margin(5)
        }.width('100%')

        Row() {
          Button('倍速：0.75').onClick(() => {
            this.curRate = PlaybackSpeed.Speed_Forward_0_75_X // 0.75倍速播放
          }).margin(5)
          Button('倍速：1').onClick(() => {
            this.curRate = PlaybackSpeed.Speed_Forward_1_00_X // 原倍速播放
          }).margin(5)
          Button('倍速：2').onClick(() => {
            this.curRate = PlaybackSpeed.Speed_Forward_2_00_X // 2倍速播放
          }).margin(5)
        }.width('100%')

      }
      .width('100%')
    }
    .height('40%')
  }
}





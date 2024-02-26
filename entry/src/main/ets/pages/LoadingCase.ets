@Entry
@Component
struct LoadingCase {
  @State message: string = 'Hello World'
  @State showLoading: boolean = false
  // 初始化执行的回调函数
  aboutToAppear() {
    this.showLoading = true
    setTimeout(() => {
      this.showLoading = false
    }, 3000)
  }

  build() {
    Row() {
      Column() {
        if(this.showLoading) {
          HmLoading()
        }else {
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
        }

      }
      .width('100%')
    }
    .height('100%')
  }
}


@Component
struct HmLoading {
  @State count: number = 0

  aboutToAppear() {
    setInterval(() => {
      if(this.count  === 100) {
        this.count = 0
      }
      this.count++
    }, 10)
  }
  build() {
    Progress({
      value: this.count,
      total: 100,
      type: ProgressType.ScaleRing
    }).style({
      strokeWidth: 6,
      scaleCount: 20,
    })
  }
}
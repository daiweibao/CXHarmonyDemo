@Entry
@Component
struct ConditionCase {
  @State showImg: boolean = false

  build() {
    Row() {
      Column() {
        Toggle({
          type: ToggleType.Switch,
          isOn: this.showImg
        })
          .onChange((isON) => {
            this.showImg = isON
          })
        if(this.showImg) {
          Image('/images/iOS12.png')
            .width(150)
            .height(150)
        }

      }
      .width('100%')
    }
    .height('100%')
  }
}
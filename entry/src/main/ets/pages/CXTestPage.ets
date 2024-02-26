import promptAction from '@ohos.promptAction'
@Entry
@Component
struct ConditionCase {
  build() {
    Row() {
      Column() {
        HmCommentItemCX({ changeLike: (obj: string) => {
           promptAction.showToast({message:`回传了数据：${obj}`})
        }})
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct HmCommentItemCX {
  changeLike: (params: string) => void = () => {}
  build() {
     Column(){
       Button('回复').onClick((event: ClickEvent) => {
         //子组件里点击回传数据
         this.changeLike('数据异步回传')
       })
     }.height('100%').width('100%')
  }
}
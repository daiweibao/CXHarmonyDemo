//Navigation演示
import App from '@system.app'
@Entry
@Component
struct CXNavigationTestPage {
  @State cIndex: number = 0
  @State bars: Array<{ text: string, num: number, img: Resource, content: Resource}> = [
    {
      text: '点赞',
      num: 0,
      img: $r('app.media.ic_tabbar_home'),
      content: $r('app.media.ic_tabbar_homeS')
    },
    {
      text: '投币',
      num: 1,
      img: $r('app.media.ic_tabbar_two'),
      content: $r('app.media.ic_tabbar_twoS')
    },
    {
      text: '收藏',
      num: 2,
      img: $r('app.media.ic_tabbar_my'),
      content: $r('app.media.ic_tabbar_myS')
    },
  ]

  build() {
    Column({space: 10}) {
      Navigation() {
        Image(this.bars[this.cIndex].content)
          .width('90%')
      }
      .title(this.NavigationTitle())//设置标题
      .hideTitleBar(false)//是否隐藏标题
      .toolBar(this.NavigationToolbar())
      .mode(NavigationMode.Auto)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F1F1')
  }

  @Builder NavigationTitle(){
    Column({space: 10}){
      Text(this.bars[this.cIndex].text).fontSize(26).fontColor(0x3E3E3E)
    }
  }

  @Builder NavigationToolbar(){
    Row(){
      ForEach(this.bars, item => {
        Column({space: 10}){
          Image(
            //设置选中和非选中的图片
              this.cIndex === item.num ?item.content: item.img
          )
            .width(50)
            .height(50)
          Text(item.text).fontSize(26).fontColor(
            //点击改变文字颜色
            this.cIndex === item.num ? Color.Blue : 0x3E3E3E
          )
        }
        .width(130)
        .height(160)
        .onClick(()=>{
          //底部标签点击事件
          this.cIndex = item.num
        })
      })
    }
  }
}


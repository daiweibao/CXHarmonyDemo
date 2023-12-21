


// 任务类
class Task{
  static id: number = 1
  // 任务名称
  name: string = `任务${Task.id++}`
  // 任务状态：是否完成
  finished: boolean = false
}

// 统一的卡片样式
@Styles function card(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4})
}

// 任务完成样式
@Extend(Text) function finishedTask(){
  .decoration({type:TextDecorationType.LineThrough})
  .fontColor('#B1B2B1')
}


@Entry
@Component
struct CXPropPage {
  //总任务数量
  @State totalTask: number = 0
  //已完成任务数量
  @State finishTask: number = 0
  //任务数组
  @State tasks:Task[] = []

  //更新任务数量
  handleTaskChange(){
    //更新任务总数
    this.totalTask = this.tasks.length
    //更新已完成任务数量。filter(item => item.finished)数组里元素按照条件过滤后留下满足条件的
    this.finishTask = this.tasks.filter(item => item.finished).length
  }

  build() {
    Row() {
      Column({space: 10}) {
        //1、任务进度卡片
        Row(){
          Text('任务进度')
            .fontWeight(FontWeight.Bold)
            .fontSize(30)

          //堆叠容器
          Stack(){
            //进度条，环形进度条等
            Progress({
              value:this.finishTask,//已经完成进度
              total: this.totalTask,//总进度
              type: ProgressType.Ring//类型：Ring环形进度条
            })
              .width('100')

            Row(){
              Text(this.finishTask.toString())
                .fontSize(24)
                .fontColor('#36D')
              Text('/' + this.totalTask.toString())
                .fontSize(24)
            }
          }
        }.card()
          .margin({top:10, bottom:10})
        .justifyContent(FlexAlign.SpaceEvenly)
        //2、新增任务按钮
        Button('新增任务')
          .width(200)
          .onClick(() => {
            //新增任务数据
            this.tasks.push(new Task())
            //更新任务数量
            this.handleTaskChange()
          })
        //3、任务列表
        List({space: 10}){
          ForEach(
            this.tasks,
            (item: Task, index) => {
              ListItem(){
                Row(){
                  Text(item.name)
                    .fontSize(20)

                  Checkbox()
                    .select(item.finished)
                    .onChange( val => {
                      //更新当前任务状态
                      item.finished = val
                      //更新任务数量
                      this.handleTaskChange()
                    })
                }
                .card()
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .swipeAction({end: this.DeleteButton(index)})//cell侧滑删除
            }
          )
        }
        .width('100%')
        .alignListItem(ListItemAlign.Center)
        .layoutWeight(1)
      }
        .width('100%')
      .height('100%')
      .backgroundColor('#F1F2F3')
    }
  }

  @Builder DeleteButton(index: number){
     Button(){
       Image($r('app.media.nav_refresh'))
     }
  }
}



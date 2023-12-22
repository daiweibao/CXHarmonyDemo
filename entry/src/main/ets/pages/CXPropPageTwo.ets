//List列表组件的增加cell、删除cell、cell添加类似iOS侧滑删除按钮
//@Observed和@ObjectLink的使用

// 任务类
@Observed//修饰数组，解决嵌套刷新问题
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

//统计信息
class StatInfo {
  //总任务数量
  totalTask: number = 0
  //已完成任务数量
  finishTask: number = 0
}


//父组件
@Entry
@Component
struct CXPropPageTwo {
  //@Provide提供者: 可以跨级传递数据
  @Provide stat: StatInfo = new StatInfo()

  build() {
    Row() {
      Column({space: 10}) {
        //任务进度
        TaskStatistics()//@Consume修饰，可以省略参数传递
        //任务列表
        TaskList()//@Consume修饰，可以省略参数传递

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F2F3')
    }
  }
}

//子组件1：任务进度组件
@Component
struct TaskStatistics {
  //统计信息
  @Consume stat: StatInfo

  build() {
    //1、任务进度卡片
    Row(){
      Text('任务进度')
        .fontWeight(FontWeight.Bold)
        .fontSize(30)

      //堆叠容器
      Stack(){
        //进度条，环形进度条等
        Progress({
          value:this.stat.finishTask,//已经完成进度
          total: this.stat.totalTask,//总进度
          type: ProgressType.Ring//类型：Ring环形进度条
        })
          .width('100')

        Row(){
          Text(this.stat.finishTask.toString())
            .fontSize(24)
            .fontColor('#36D')
          Text('/' + this.stat.totalTask.toString())
            .fontSize(24)
        }
      }
    }.card()
    .margin({top:10, bottom:10})
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

//子组件2
@Component
struct TaskList {
  //要与@Provider的变量名保持一致，都叫stat
  @Consume stat: StatInfo
  //任务数组
  @State tasks:Task[] = []

  //更新任务数量函数
  handleTaskChange(){
    //更新任务总数
    this.stat.totalTask = this.tasks.length
    //更新已完成任务数量。filter(item => item.finished)数组里元素按照条件过滤后留下满足条件的
    this.stat.finishTask = this.tasks.filter(item => item.finished).length
  }

  build() {
    Column(){
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
              //通过参数传递函数：this.handleTaskChange.bind(this)；bind(this)是把当前的this传递给组件
             TaskItem({item: item, onTaskChange: this.handleTaskChange.bind(this)})
            }
            .swipeAction({end: this.DeleteButton(index)})//cell侧滑删除
          }
        )
      }
      .width('100%')
      .alignListItem(ListItemAlign.Center)
      .layoutWeight(1)
    }
  }

  @Builder DeleteButton(index: number){
    //删除按钮
    Button(){
      //按钮上的图片
      Image($r('app.media.ic_public_delete'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Orange)
    .margin(10)
    .onClick( () => {
      //删除按钮点击事件：删除数组元素（从那个元素开始删除，删除几个）
      this.tasks.splice(index, 1)
      this.handleTaskChange()
    })
  }
}


@Component
struct TaskItem {
  @ObjectLink item: Task
  //定义一个函数，接收外界传入
  onTaskChange: () => void
  build() {
    Row(){
      if (this.item.finished){
        Text(this.item.name)
          .fontSize(20)
          .finishedTask()
      }else {
        Text(this.item.name)
          .fontSize(20)
      }

      Checkbox()
        .select(this.item.finished)//是否选中
        .onChange( isSelected => {
          //更新当前任务状态
          this.item.finished = isSelected
          //更新任务数量
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}




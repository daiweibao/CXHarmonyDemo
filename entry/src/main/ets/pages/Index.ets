
//Entry、Component 装饰器，用来装饰类结构、方法、变量
@Entry//标记当前组件是入口组件，其他地方可以调用
@Component//标记自定义组件
struct Index {//自定义组件：可复用的UI单元

  //@state：标记该变量是状态变量，值变化时会融发UI剧新
  @State message: string = 'Hello World'

  build() {//build是：UI描述，其内部以【声明式】方式描述UI工结构
    Row() {//行
      //下面UI组件有ArkUI提供
      Column() {//列
        //声明一个文本
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
        .width('100%')
    }
    .height('100%')
  }
}


/*
  @State times: number = 0
 //声明一个button
 Button(`点我${this.times} 次`)//注意用（`）符号而不是单引号（'）
 .backgroundColor('#36D')
 .onClick(() => this.times++)

 * */
// @ts-nocheck
// @Provide、@Consume使用案例
// @Entry
@Component
struct ProviderConsume {
  //@Provide提供者: 可以跨级传递数据
  @Provide message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            this.message = "Hillo"
          })

        ProviderConsume_sun()
      }
      .width('100%')
    }
    .height('100%')
  }
}

// 后代组件
@Component
struct ProviderConsume_sun {
  //要与@Provider的变量名保持一致,都叫：message。不能初始化值。
  @Consume message: string
  build() {
    Column() {
      Text('孙子：' + this.message)
        .fontSize(20)
        .onClick(()=>{
          this.message = "99999999"
        })
    }
  }
}



// xxx.ets
@Entry
@Component
struct CompA {
  //括号里写监听方法名字
  @State @Watch("onChanged") count : number = 0

  build() {
    Column() {
      Button('add to basket ' + this.count)
        .margin(15)
        .onClick(() => {
          //点击修改属性
          this.count++
        })
      Text(`${this.count}`)
        .fontSize(30)
    }
  }
  // 监听方法
  onChanged(){
    AlertDialog.show({
      title:'走了监听方法',
      primaryButton:{
        value: '确定'
      }
    })
  }
}

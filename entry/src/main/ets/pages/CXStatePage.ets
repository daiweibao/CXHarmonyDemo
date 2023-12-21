//@State演示

class Person {
  name: string
  age: number
  gf: Person//嵌套
  constructor(name: string, age: number, gf?:Person) {
    this.name = name
    this.age = age
    this.gf = gf
  }
}

//案例1
// @Entry
@Component
struct CXStatePage {
  @State name: string = 'Jack'
  @State age: number = 21

  build() {
    Row() {
      Column() {
        Text(`${this.name}:${this.age}`)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.age++
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

//案例2：对象和嵌套类型
// @Entry
@Component
struct CXStatePage2 {
@State P: Person = new Person('Jack', 21, new Person('Rose', 18))
  build() {
    Row() {
      Column() {
        Text(`${this.P.name}:${this.P.age}`)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.P.age++
          })
        Text(`${this.P.gf.name}:${this.P.gf.age}`)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.P.gf.age++
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}



//案例3：数组刷新
@Entry
@Component
struct CXStatePage3 {
  idx: number = 1
  @State gfs: Person[] = [
    new Person('肉丝', 18),
    new Person('路西', 19)
  ]
  build() {
    Row() {
      Column() {
        Button('添加')
          .onClick(() => {
            //点击添加数组元素
            this.gfs.push(new Person('女友'+ this.idx++, 20))
          })

        Text('==女友列表==')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        ForEach(this.gfs, (pp, index) => {
          Row(){
            Text(`${pp.name}:${pp.age}`)
              .fontSize(30)
              .onClick(() => {
                //点击覆盖添加数组，菜可以刷新嵌套数据
                this.gfs[index] = new Person(pp.name, pp.age+1)
              })

            Button('删除')
              .onClick(() => {
                //删除数组元素，删除指定角标，删除1个
                this.gfs.splice(index, 1)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
        })
      }
      .width('100%')
    }
    .height('100%')
    .alignItems(VerticalAlign.Top)
  }
}




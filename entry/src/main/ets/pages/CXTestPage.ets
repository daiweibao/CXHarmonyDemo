

//【通用】实现IDataSource系统相关接口
class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];
  private originDataArray: StringData[] = [];//原始数据类型为自定义：StringData
  // 获得数据总数
  public totalCount(): number {
    return 0;
  }
  // 获取索引值对应的数据：StringData
  public getData(index: number): StringData {
    return this.originDataArray[index];
  }
  //注册数据改变的监听器：该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }
  //注销数据改变的监听器：该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }
  // 【刷新所有数据】通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }
  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }
  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }
  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }
}
//【根据业务自定义】继承BasicDataSource实现自己的数据类
class MyDataSource extends BasicDataSource {
  private dataArray: StringData[] = [];
  // 获得数据总数
  public totalCount(): number {
    return this.dataArray.length;
  }
  // 获取索引值对应的数据：StringData
  public getData(index: number): StringData {
    return this.dataArray[index];
  }
  //指定角标添加数据：StringData
  public addData(index: number, data: StringData): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }
  //在数据源【末尾添加数】据并调用notifyDataAdd方法
  public pushData(data: StringData): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }
}

//状态监听类--数据
@Observed
class StringData {
  message: NestedString;
  constructor(message: NestedString) {
    this.message = message;
  }
}

// @ObjectLink装饰的成员变量仅能监听到其子属性的变化，再深入嵌套的属性便无法观测到了，这里@Observed修饰无效
@Observed
class NestedString {
  message: string;
  constructor(message: string) {
    this.message = message;
  }
}

//cell子组件封装
@Component
struct ChildComponent {
  //状态监听对象
  @ObjectLink data: StringData
  build() {
    Row() {
      Text(this.data.message.message).fontSize(50)
        .onAppear(() => {
          console.info("appear:" + this.data.message.message)
        })
    }.margin({ left: 10, right: 10 })
  }
}


@Entry
@Component
struct MyComponent {
  //状态
  @State data: MyDataSource = new MyDataSource();

  aboutToAppear() {
    //控件将要创建
    for (let i = 0; i <= 20; i++) {
      //数组里存放StringData数据对象
      this.data.pushData(new StringData(new NestedString(`Hello ${i}`)));
    }
  }

  build() {
    List({ space: 3 }) {
      LazyForEach(this.data, (item: StringData, index: number) => {
        ListItem() {
          //封装cell子组件
          ChildComponent({data: item})
        }
        .onClick(() => {
          // item.message.message += '0';//修改无效
          //有效修改：新建一个子属性替换
          item.message = new NestedString(item.message.message + '0');
        })
      }, (item: StringData, index: number) => item.toString() + index.toString())
    }.cachedCount(5)
  }
}




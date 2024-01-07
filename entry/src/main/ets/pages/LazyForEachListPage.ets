// LazyForEachListPage使用案例

//【通用】实现IDataSource系统相关接口
class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];//监听
  private originDataArray: string[] = [];//原始数据

  // 获得数据总数
  public totalCount(): number {
    return 0;
  }

  // 获取索引值对应的数据
  public getData(index: number): string {
    return this.originDataArray[index];
  }

  //注册数据改变的监听器：该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('数据源添加了数据');
      this.listeners.push(listener);
    }
  }

  //注销数据改变的监听器：该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('数据源删除了数据');
      this.listeners.splice(pos, 1);
    }
  }

  // 【刷新所有数据】通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();// 重新加载数据完成后调用
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);// 添加数据完成后调用
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);// 改变数据完成后调用
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);// 删除数据完成后调用
    })
  }
}

//【根据业务自定义】继承BasicDataSource实现自己的数据类
class MyDataSource extends BasicDataSource {
  //创建一个空数组，用于存放数据源
  // private dataArray: string[] = [];
  //删除数据的时候这里不要设置private，不然外部取不到
  dataArray: string[] = [];

  // 获得数据总数
  public totalCount(): number {
    return this.dataArray.length;
  }

  // 获取索引值对应的数据
  public getData(index: number): string {
    return this.dataArray[index];
  }

  //此方法暂未使用
  public addData(index: number, data: string): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  //在数据源【末尾添加数】据并调用notifyDataAdd方法
  public pushData(data: string): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  //根据角标删除数据
  public deleteData(index: number): void {
    this.dataArray.splice(index, 1);
    this.notifyDataDelete(index);
  }

  //修改数据
  public changeData(index: number, data: string): void {
    this.dataArray.splice(index, 1, data);
    this.notifyDataChange(index);
  }

  //【刷新所有数据】通知LazyForEach组件需要重载所有子组件
  public reloadData(): void {
    this.notifyDataReload();
  }

  //修改所有数据
  public modifyAllData(): void {
    //根据业务处理数据，比如刷新加载
    //在所有数据后面分别添加一个0，返回一个新的数组
    this.dataArray = this.dataArray.map((item: string) => {
      return item + '0';
    })
  }
}

@Entry
@Component
struct MyComponent {
  //数据源
  private data: MyDataSource = new MyDataSource();

  aboutToAppear() {
    //页面初始化时候添加数据
    for (let i = 0; i <= 20; i++) {
      this.data.pushData(`Hello ${i}`)
    }
  }

  build() {
    List({ space: 3 }) {
      LazyForEach(this.data, (item: string, index: number) => {
        ListItem() {
          Row() {
            Text(item).fontSize(50)
              .onAppear(() => {
                console.info("appear:" + item)
              })
          }.margin({ left: 10, right: 10 })
        }
        .onClick(() => {
          //点击item控件 控件点击事件
          //点击修改指定角标数据内容
          this.data.modifyAllData();
          //刷新所有数据
          this.data.reloadData();
        })
      }, (item: string, index: number) => item + index.toString())//键值生成规则是keyGenerator函数的返回值item。在LazyForEach循环渲染时，其为数据源数组项依次生成键值，并创建对应的ListItem子组件渲染到界面上。这里索引不能重复
      //假如这里写死为same key： (item: string) => 'same key') 会导致组件渲染错乱。所以这里不能写死

    }.cachedCount(5)//cachedCount：可配置cachedCount属性，即只加载可视部分以及其前后少量数据用于缓冲
  }
}




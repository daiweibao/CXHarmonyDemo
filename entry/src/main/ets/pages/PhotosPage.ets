import picker from '@ohos.file.picker';

@Entry
@Component
struct Index {
  @State imgDatas: string[] = [];
  // 获取照片url集
  getAllImg() {

    let result = new Array<string>();
    try {
      let PhotoSelectOptions = new picker.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 5;
      let photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
        this.imgDatas = PhotoSelectResult.photoUris;
        console.info('图库照片选择成功：' + JSON.stringify(PhotoSelectResult));
      }).catch((err) => {
        console.error(`PhotoViewPicker.select failed with. Code: ${err.code}, message: ${err.message}`);
      });
    } catch (err) {
      console.error(`PhotoViewPicker failed with. Code: ${err.code}, message: ${err.message}`);    }
  }

  //aboutToAppear中调用上述函数，获取图库的所有图片url，存在imgDatas中
  async aboutToAppear() {

  }

  // 使用imgDatas的url加载图片。
  build() {
    Column() {
      Button('打开相册').onClick((event: ClickEvent) => {
        //打开图库
        this.getAllImg();
      })
      Grid() {
        ForEach(this.imgDatas, item => {
          GridItem() {
            Image(item)
              .width(200)
          }
        }, item => JSON.stringify(item))
      }
    }.width('100%').height('100%')
  }
}

@Entry
@Component
struct FocusableExample {
  @State inputValue: string = ''
  // @State textFocusable: boolean = false;
  build() {
    Scroll() {
      Column({ space: 20 }) {
        //输入框
        TextInput({placeholder:'请输入手机号'})
        .key('phoneTextInput')//绑定key
        TextInput({placeholder:'密码'})
          .key('phoneTextInput2')//绑定key2

        Button('点击关闭键盘')
          .focusOnTouch(true)//点击获得焦点，使输入框失去焦点
          .onClick(()=>{

          })
        Button('点击弹出键盘')
          .onClick(()=>{
            //主动申请焦点能力的全局方法，参数：string，参数表示被申请组件的id（通用属性id设置的字符串）。
            focusControl.requestFocus('phoneTextInput')
            sendEventByKey('phoneTextInput', 10, '弹出键盘')
          })
        Button('切换焦点')
          .onClick(()=>{
            //主动申请焦点能力的全局方法，参数：string，参数表示被申请组件的id（通用属性id设置的字符串）。
            focusControl.requestFocus('phoneTextInput2')//切换焦点
            sendEventByKey('phoneTextInput2', 10, '弹出键盘')//弹出键盘
          })

      }.alignItems(HorizontalAlign.Center)
    }
  }
}
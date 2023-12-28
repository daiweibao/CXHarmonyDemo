import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import { CXNavView } from '../CXComponents/CXNavComponent'
@Entry
@Component
struct DocumentListPage {
  private index: number = 1
  @State docs: number[] = []

  private context = getContext(this) as common.UIAbilityContext

  build() {
    Row() {
      Column({space: 10}) {
        CXNavView({navTitle: '文档列表'})
        Divider()
        Button('新建文档')
          .onClick(() => {
            // 添加文档
            this.docs.push(this.index)

            //从入口UIAbility跳转到文档编辑的 UIAbility
            // 跳转的目的地want
            let want: Want = {
              deviceId: '',// deviceId为空表示本设备
              bundleName: 'com.example.myapplication',
              moduleName: 'entry',
              abilityName: 'DocumentAbility',
              parameters: {
                instanceKey: 'idx_' + this.index++
              }
            }
            // 跳转UIAbility
            this.context.startAbility(want)

          })
        ForEach(this.docs, id => {
          Row({space:10}){
            Image($r('app.media.ic_files_doc'))
              .width(20)
            Text(`文档${id}`)
              .fontSize(18)
              .onClick(() => {

                // 跳转到文档编辑的UIAbility
                // 跳转的目的地want
                let want: Want = {
                  deviceId: '',// deviceId为空表示本设备
                  bundleName: 'com.example.myapplication',
                  moduleName: 'entry',
                  abilityName: 'DocumentAbility',
                  parameters: {
                    instanceKey: 'idx_' + id
                  }
                }
                // 跳转到UIAbility
                this.context.startAbility(want)


              })
          }
          .width('100%')
        })
      }
      .width('100%')
      .height('100%')
      .padding(20)
    }
  }
}

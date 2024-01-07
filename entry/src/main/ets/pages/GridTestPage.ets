@Entry
@Component
struct GridTestPage {

  build() {
    Grid() {
      GridItem() {
        Text('会议')
      }

      GridItem() {
        Text('签到')
      }

      GridItem() {
        Text('投票')
      }

      GridItem() {
        Text('打印')
      }
    }
    .rowsTemplate('1fr 1fr')
    .columnsTemplate('1fr 1fr')

  }
}


@Component
struct Child {
  label: string = `Child`
  @BuilderParam aBuilder0: () => void;

  build() {
    Column() {
      Button()
        .onClick(()=>{
        })
      this.aBuilder0()
    }
  }
}

@Entry
@Component
struct Parent {
  label: string = `Parent`

  @Builder componentBuilder() {
    Text(`${this.label}`).fontColor('#36D')
  }

  build() {
    Column() {
      this.componentBuilder()
      Child({ aBuilder0: this.componentBuilder })
    }
  }
}



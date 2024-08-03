//使用时需在外面包一层正方形盒子

@Component
export struct Avatar{
  @Prop content:string|Resource
  build() {
    Flex({justifyContent:FlexAlign.Center,alignItems:ItemAlign.Center}){
      if(typeof this.content==='string'){
        Text(this.content[0])
          .fontSize(18)
          .fontColor('#fff')
      }else {
        Image(this.content)
          .width('100%')
          .height('100%')
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor(typeof this.content==='string'?$r('app.color.theme_color'):'transparent')
    .borderRadius(8)
  }
}
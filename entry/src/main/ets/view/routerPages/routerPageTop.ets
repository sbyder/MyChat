import router from '@ohos.router'

@Component

export struct routerPageTop{
  @Prop title:string
  build() {
    Flex(
      {
        justifyContent:FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center
      }
    ){
      //返回箭头
      Text()
        .width(15)
        .height(15)
        .border({width:{left:1,bottom:1},color:'#000'})
        .rotate({angle:45})
        .backgroundColor('transparent')
        .onClick(()=>{
          router.back()
        })
      //标题
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
      //占位的
      Text()
        .width(15)
        .height(15)
    }.width('100%')
    .height(50)
    .padding(10)
    .backgroundColor(Color.Transparent)
  }
}
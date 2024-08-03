import { ItemType } from '../../../common/enums/ItemType'

@Component
export struct comItem {
  @Prop iconSrc: Resource
  @Prop title: string
  @Prop itemtype:ItemType

  build() {
    Button({type: ButtonType.Normal, stateEffect: true}) {
      Flex({
        justifyContent:FlexAlign.SpaceBetween,
        alignItems:ItemAlign.Center
      }){
        if(this.itemtype===ItemType.Style2){
          Text(this.title)
            .textAlign(TextAlign.Center)
            .fontColor(Color.Black)
            .fontSize(19)
            .flexGrow(1)
        }else {
          if(this.iconSrc){
            Image(this.iconSrc)
              .width(25)
              .height(25)
          }
          Text(this.title)
            .margin({left:10})
            .fontColor(Color.Black)
            .fontSize(19)
            .flexGrow(1)
          Text()
            .width(10)
            .height(10)
            .border({width:{right:1,bottom:1},color:Color.Gray})
            .rotate({angle:-45})
        }

      }

    }
    .width("100%")
    .height(60)
    .backgroundColor("#fff")
    .padding({ left: 15, right: 15 })
  }
}
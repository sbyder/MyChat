
import { Moment } from '../../../../common/models/Moment'
import { Avatar } from '../../../Avatar/Avatar'

@Component
export struct momentsList{
  @Prop moments:Moment[]
  build() {
    Column(){
      ForEach(this.moments,(moment:Moment)=>{
        Flex(){
          //avatar
          Flex(){
            Flex(){
              Avatar({content:moment.nickname})
            }.width(50)
            .height(50)
          }.width(60)

          //content
          Column(){
            //nickname
            Text(moment.nickname)
              .fontColor('#576B95')
            //real content
            Text(moment.content)
              .margin({top:5})
            //subbox
            Row(){
              Text(moment.date)
                .fontSize(15)
                .fontColor(Color.Gray)
              Button({type:ButtonType.Normal}){
                Text('● ●')
                  .fontSize(6)
                  .fontColor('#576B95')
              }
              .width(30)
              .height(20)

              .borderRadius(5)
              .backgroundColor($r('app.color.grey'))
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
            .margin({top:10})
          }
          .flexGrow(1)
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
          .padding(3)
          .margin({left:2})
        }.width('100%')
        .padding(10)
      })
    }
    .width('100%')
    // .height('55%')//父组件剩下的空间
    .backgroundColor(Color.White)

  }
}


import { Avatar } from '../../Avatar/Avatar'
import { comItem } from '../../commonView/comItem/comItem'
import { router } from '@kit.ArkUI'

@Component
export struct Mine{
  @StorageLink('user_id') user_id:number=0
  @StorageLink('nickname') nickname:string="未知用户"
  build() {
    Column({space:20}){
      //me
      Row(){
        Flex(){
          Avatar({content:this.nickname})
        }.width(60)
        .height(60)
        Column(){
          Text(this.nickname)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
          Text(`uid: ${this.user_id}`)
            .fontColor(Color.Gray)
        }.height('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(HorizontalAlign.Start)
        .padding(5)
        .margin({left:5})
      }.width('100%')
      .height(120)
      .padding({left:15,right:15,top:30,bottom:30})
      .backgroundColor('#fff')
      //menu
      Column(){
        comItem({ title: "设置",
          iconSrc: $r('app.media.ic_setting')
        }).onChildTouchTest(()=>{
          router.pushUrl({url:'pages/routerPages/indexPages/Setting'})
          return { strategy: TouchTestStrategy.DEFAULT }
        })
      }
    }.height('100%')
  }
}
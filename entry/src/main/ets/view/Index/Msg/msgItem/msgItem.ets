import { Chat } from '../../../../common/models/Chat'
import {Avatar} from '../../../Avatar/Avatar'
import { router } from '@kit.ArkUI'
import { stampToTime } from '../../../../common/utils/stampToTime'

@Component
export struct msgItem{
  @Prop chat:Chat
  @StorageLink('chats') chats:Chat[]=[]
  build() {
    Button({type: ButtonType.Normal, stateEffect: true}){
      Flex({justifyContent:FlexAlign.SpaceBetween }){
        //avatar
        Flex(){
          Avatar({content:this.chat.friend.nickname})
        }.width(60)
        .height(60)
        //nickname+transcript
        Column(){
          //nickname
          Text(this.chat.friend.nickname)
            .fontSize(18)
          //transcript
          Text(this.chat.preview)
            .comLightFont()
        }.height('100%')
        .flexGrow(1)
        .padding(5)
        .margin({left:5})
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceBetween)
        //redpoint
        if(this.chat.unread_amount>0){
          Text(this.chat.unread_amount>99?'99':`${this.chat.unread_amount}`)
            .position({left:60})
            .translate({x:'-50%'})
            .width(18)
            .height(18)
            .borderRadius(18)
            .textAlign(TextAlign.Center)
            .fontSize(13)
            .fontColor(Color.White)
            .backgroundColor(Color.Red)
        }
        //time
        Flex({justifyContent:FlexAlign.End }){
          //将 7月30日 16:00 变为7月30日
          Text(stampToTime(this.chat.timestamp).split(' ')[0])
            .comLightFont()
        }.height('100%')
        .width(80)
        .padding(5)
      }
      .height('100%')
      .padding(10)
    }
    .height('80')
    .backgroundColor('#fff')
    .onClick(()=>{
      //Prop修饰符无法将修改同步到父组件
      //Link修饰符又无法深层检测
      //Observe修饰符需要对整个类进行修饰, 而不是特定变量, 有点奇怪
      //故在此进行chat_id匹配并将unread_amount归零
      this.chats.forEach((chat,index)=>{
        if(chat.chat_id===this.chat.chat_id){
          let tempchat=chat
          tempchat.unread_amount=0
          this.chats.splice(index,1, tempchat)
        }
      })
      router.pushUrl({
        url:'pages/routerPages/indexPages/chatWindow',
        params:{
          chat_id:this.chat.chat_id,
          friend:this.chat.friend
        }
      })
    })

  }
}

@Extend(Text) function comLightFont(){
  .fontSize(13)
  .fontColor('#ff7e7e7e')
}

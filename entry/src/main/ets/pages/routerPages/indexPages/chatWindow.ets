import { AxiosResponse } from '@ohos/axios'
import { Message } from '../../../common/models/Message'
import { myShowToast } from '../../../common/utils/myShowToast'
import { getMessages } from '../../../http/Api'
import { routerPageTop } from '../../../view/routerPages/routerPageTop'
import {  router } from '@kit.ArkUI'
import { Chat } from '../../../common/models/Chat'
import { comButton } from '../../../view/commonView/comButton/comButton'
import { BtnType } from '../../../common/enums/BtnType'
import { ws } from '../../../ws/ws'
import { User } from '../../../common/models/User'
import { stampToTime } from '../../../common/utils/stampToTime'

@Component
@Entry struct chatWindow{
  params=router.getParams()
  chat_id:number=(this.params as Chat).chat_id
  friend:User=(this.params as Chat).friend

  @StorageLink('user_id') user_id:number=2
  @State content:string=''
  @State isdisable:boolean=true

  @StorageLink('tempmsgid') tempmsgid:number=0
  @Watch('ontempmsgsChange') @StorageLink('tempmsgs') tempmsgs:Message[]=[]
  scroller: Scroller = new Scroller()
  ontempmsgsChange(){
    this.scroller.scrollEdge(Edge.Bottom)
  }
  onPageShow() {
    //修改tempmsgid意味着新的消息会通过tempmsgs传入, 若在获取到messages之前修改可能导致信息乱序
    //但若在messages之后修改, 又可能导致再服务端将数据库返回的messages返回到前端的过程中的message丢失
    this.tempmsgid=this.chat_id
    getMessages(this.chat_id).then((res:AxiosResponse)=>{
      switch (res.data.status){
        case 0:
          // if(this.tempmsgs.length)
          //不管在getMessages执行期间有没有message传入tempmsgs, unshift总没错
          this.tempmsgs.unshift(...(res.data.messages as Message[]))
          this.scroller.scrollEdge(Edge.Bottom)
          break
        default :
          myShowToast('未知错误')
      }
    })
  }
  onPageHide(){
    this.tempmsgid=0
    this.tempmsgs=[]
  }
  build() {
    Flex({
      direction:FlexDirection.Column,
      justifyContent:FlexAlign.SpaceBetween
    }){
      routerPageTop({title:this.friend.nickname})
      List({space:10,scroller:this.scroller}){
        ForEach(this.tempmsgs,(message:Message,index:number)=>{
          if (!index||message.timestamp-this.tempmsgs[index-1].timestamp>180000){
            ListItem(){
              Text(stampToTime(message.timestamp))
                .width('100%')
                .textAlign(TextAlign.Center)
            }.width('100%')
          }
          ListItem(){
            Row(){
              Text(message.content)
                .constraintSize({maxWidth:'50%'})
                .padding(15)
                .borderRadius(5)
                .fontColor(message.send_user_id===this.user_id?'#000':$r('app.color.grey'))
                .backgroundColor(message.send_user_id===this.user_id?'#fff':$r('app.color.theme_color'))
            }
            .width('100%')
            .justifyContent(message.send_user_id===this.user_id?FlexAlign.End:FlexAlign.Start)
          }.width('100%')
        })
      }
      .width('100%')
      .flexGrow(1)
      .padding(10)
      .backgroundColor($r('app.color.grey'))
      .edgeEffect(EdgeEffect.Fade)
      Row({space:10}){
        TextInput({text:this.content})
          .width('70%')
          .onChange((value)=>{
            this.content=value
            this.isdisable=!value
          })
        comButton({content:'发送',btntype:BtnType.Blue,isDisable:this.isdisable})
          .width('50%')
          .onChildTouchTest(()=>{

            if(this.content){

              let message=new Message(this.chat_id,
              this.user_id,
              this.friend.user_id,
              this.content,
              Date.now())

              const messageString = JSON.stringify(message)
              ws.send(messageString)

              this.tempmsgs.push(message)

              this.content=''
            }
            return { strategy: TouchTestStrategy.DEFAULT }
          })
      }
      .width('100%')
      .padding(5)
    }.width('100%')
    .height('100%')

  }
}
import { Tab } from '../common/models/Tab'
import { Msg } from '../view/Index/Msg/Msg'
import {addressList} from '../view/Index/addressList/addressList'
import { Find } from '../view/Index/Find/Find'
import { Mine } from '../view/Index/Mine/Mine'
import { getChats, searchUserbyID } from '../http/Api'
import { AxiosResponse } from '@ohos/axios'
import { myShowToast } from '../common/utils/myShowToast'
import { Chat } from '../common/models/Chat'
import { ws } from '../ws/ws'
import { Message } from '../common/models/Message'

@Entry
@Component

struct BarCustomPage {
  @State currentIndex: number = 0;
  @StorageLink('user_id') user_id:number=2
  @StorageLink('nickname') nickname:string="cwp"
  @StorageLink('chats') chats:Chat[]=[]

  //通过应用级变量tempmsgid来标识用户位置, 以判断消息展示方式
  //tempmsgid为0时用户不在聊天窗口,用户进入聊天窗口时tempmsgid为对应窗口的chat_id
  @StorageLink('tempmsgid') tempmsgid:number=0
  @StorageLink('tempmsgs') tempmsgs:Message[]=[]
  tabs:Tab[]=[
    new Tab(0,"信息","xinxi"),
    new Tab(1,"通讯录","tongxunlu"),
    new Tab(2,"发现","faxian"),
    new Tab(3,"我的","wode"),
  ]
  aboutToAppear(){
    //
    getChats(this.user_id).then((res:AxiosResponse)=>{
      switch (res.data.status){
        case 0:
          this.chats=res.data.chats
          break
        default :
          myShowToast('未知错误')
      }
    })
    //
    ws.on('open', (err, value) => {
      console.log("on open, status:" + JSON.stringify(value));
    });
    ws.on('message', (err, value) => {
      const message:Message=JSON.parse(value as string)

      //修改chat
      let tempchat:Chat=new Chat()
      //找到对应chat_id并修改
      this.chats.forEach((chat,index)=>{
        if(chat.chat_id===message.chat_id){
          tempchat=this.chats[index]
          tempchat.preview=message.content
          tempchat.timestamp=message.timestamp
          tempchat.unread_amount++
          this.chats.splice(index,1)
          this.chats.unshift(tempchat)
        }
      })
      //没遍历到message.chat_id,说明该chat是由其它用户创建的
      if(tempchat.chat_id===0){
        searchUserbyID(message.send_user_id).then((res:AxiosResponse)=>{
          switch (res.data.status){
            case 0:
              tempchat.preview=message.content
              tempchat.timestamp=message.timestamp
              tempchat.unread_amount++
              tempchat.chat_id=message.chat_id
              tempchat.friend=res.data.friend
              this.chats.unshift(tempchat)
              break
            default :
              myShowToast('未知错误')
          }
        })
      }

      // if(this.tempmsgid!==0)
      message.chat_id===this.tempmsgid?this.tempmsgs.push(message):null
    });
  }
  onPageShow(){
    getChats(this.user_id).then((res:AxiosResponse)=>{
      switch (res.data.status){
        case 0:
          this.chats=res.data.chats
          break
        default :
          myShowToast('未知错误')
      }
    })
  }
  build() {
    Flex({direction: FlexDirection.Column}){
      Text(this.tabs[this.currentIndex].title)
        .width('100%')
        .height(50)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .backgroundColor($r('app.color.grey'))
      Tabs() {
        ForEach(this.tabs,(item:Tab,index:number)=>{
          TabContent() {
            if(index===0){Msg()}
            else if(index===1){addressList()}
            else if(index===2){Find()}
            else if(index===3){Mine()}
          }.backgroundColor($r('app.color.grey'))
          .tabBar(this.barBuilder(item))
        },(item:Tab) => JSON.stringify(item)
        )
      }
      .backgroundColor('#fff')
      .flexGrow(1)
      .barPosition(BarPosition.End)
      .onChange((index) => {
        this.currentIndex = index;
      })
    }
  }
  @Builder barBuilder(item:Tab){
    Column() {
      Image(item.isSelected(this.currentIndex) ? item.iconSelected : item.icon)
        .width(25)
        .height(25)
      Text(item.title)
        .fontColor(item.isSelected(this.currentIndex) ? $r('app.color.theme_color') : '#000')
        .fontWeight(FontWeight.Normal)
    }
  }
}


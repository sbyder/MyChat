import { AxiosResponse } from '@ohos/axios'
import { User } from '../../common/models/User'
import { myShowToast } from '../../common/utils/myShowToast'
import { createChat } from '../../http/Api'
import { Avatar } from '../Avatar/Avatar'
import { router } from '@kit.ArkUI'

@CustomDialog
export struct perInfoDialog{
  controller?: CustomDialogController
  @Prop friend:User
  @StorageLink('user_id') user_id:number=23
  @StorageLink('nickname') nickname:string="企鹅"
  build() {
    Column(){
      //试图让头像translate到边框外,但好像没有overflow可见的选项,头像会被截掉
      //故让大盒子的背景透明,小盒子背景改为白色,且布局为从底部开始
      //此时将小盒子的高度调为百分比,那么剩下的区域就是头像能放置且不会被截掉的区域
      Flex({justifyContent:FlexAlign.Center}){
        Flex(){
          Avatar({content:this.friend.nickname})
        }.width(70)
        .height(70)
        .position({x:'50%'})
        .translate({x:'-50%',y:'50%'})

      }
      .width('100%')
      .height(70)
      .backgroundColor(Color.Transparent)
      .zIndex(1)
      //小盒子
      Column(){
        Column(){
          Text(this.friend.nickname)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
          Text(`uid: ${this.friend.user_id}`)
            .fontColor(Color.Gray)
        }
        Button(){
          Text('聊天')
            .fontColor('#000')
        }
        .type(ButtonType.Normal)
        .width('35%')
        .height(40)
        .borderRadius(10)
        .backgroundColor($r('app.color.grey'))
        .onClick(()=>{
          createChat([this.user_id,this.friend.user_id]).then((res:AxiosResponse)=>{
            switch (res.data.status){
              case 0:
                this.controller?.close()
                router.pushUrl({
                  url:'pages/routerPages/indexPages/chatWindow',
                  params:{
                    chat_id:res.data.chat_id,
                    friend:this.friend.user_id
                  }
                })
                break
              case 1:
                myShowToast('未知错误')
                break
              default :
                myShowToast('未知错误')
                break
            }
          })

        })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height(130)//
      .padding({top:40,bottom:20})
      .borderRadius(20)
      .backgroundColor(Color.White)
    }
    .justifyContent(FlexAlign.End)
    .width('100%')//250
    .height('100%')//200
    .backgroundColor(Color.Transparent)
  }
}
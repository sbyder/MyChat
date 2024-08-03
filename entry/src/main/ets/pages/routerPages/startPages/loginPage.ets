import { AxiosResponse } from '@ohos/axios'
import { BtnType } from '../../../common/enums/BtnType'
import { Login } from '../../../http/Api'
import { comButton } from '../../../view/commonView/comButton/comButton'
import { comInput } from '../../../view/commonView/comInput/comInput'

import {routerPageTop} from "../../../view/routerPages/routerPageTop"
import { router } from '@kit.ArkUI'
import { myShowToast } from '../../../common/utils/myShowToast'

@Entry
@Component

struct loginPage{
  @State @Watch('onInputChange') inputnickname:string=''
  @State @Watch('onInputChange') inputpassword:string=''
  @State btnisdisable:boolean=true
  @StorageLink('user_id') user_id:number=0
  @StorageLink('nickname') nickname:string="未知用户"

  onInputChange(){
    this.btnisdisable=!(this.inputnickname&&this.inputpassword)
  }

  build() {
    Flex({
      direction:FlexDirection.Column
    }){
      routerPageTop({title:'登陆'})//
      Column({space:80}){
        Column(){
          comInput({
            title:'昵称',
            placeholder:'请输入昵称',
            type:InputType.Normal,
            value:$inputnickname
          })
          comInput({
            title:'密码',
            placeholder:'请输入密码',
            type:InputType.Password,
            value:$inputpassword
          })
        }
        comButton({
          content:"登陆",
          btntype:BtnType.Blue,
          routerinfo:"",
          isDisable:this.btnisdisable
        })
          .onChildTouchTest(()=>{
            if(!(this.inputnickname&&this.inputpassword)){
              console.log("密码和昵称不能为空")
              return { strategy: TouchTestStrategy.DEFAULT }
            }
            Login(this.inputnickname,this.inputpassword).then((res:AxiosResponse)=>{
              switch (res.data.status){
                case 0:
                  myShowToast('无效用户名')
                  break
                case 1:
                  myShowToast('密码错误')
                  break
                case 2:
                  //将服务器返回的user_id存到本地
                  this.user_id=res.data.user_id
                  this.nickname=this.inputnickname
                  router.replaceUrl({url:'pages/Index'})
                  break
                default :
                  myShowToast('未知错误')
              }
            })


            //onChildTouchTestb函数必须返回{ strategy: TouchTestStrategy }
            return { strategy: TouchTestStrategy.DEFAULT }
          })
      }.justifyContent(FlexAlign.Center)
      .flexGrow(1)


    }

    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.grey'))


  }
}
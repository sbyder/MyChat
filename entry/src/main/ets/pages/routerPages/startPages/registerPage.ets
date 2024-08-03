import { AxiosResponse } from '@ohos/axios'
import { BtnType } from '../../../common/enums/BtnType'
import { myShowToast } from '../../../common/utils/myShowToast'
import {  Register } from '../../../http/Api'
import { comButton } from '../../../view/commonView/comButton/comButton'
import { comInput } from '../../../view/commonView/comInput/comInput'
import {routerPageTop} from "../../../view/routerPages/routerPageTop"
import { router } from '@kit.ArkUI'

@Entry
@Component

struct registerPage{
  @State @Watch('onInputChange') inputnickname:string=''
  @State @Watch('onInputChange') inputpassword:string=''
  @State @Watch('onInputChange') repeatinputpassword:string=''
  @State btnisdisable:boolean=true
  @StorageLink('user_id') user_id:number=0
  @StorageLink('nickname') nickname:string="未知用户"

  onInputChange(){
    this.btnisdisable=!(this.inputnickname&&this.inputpassword&&this.repeatinputpassword)
  }

  build() {
    Flex({
      direction:FlexDirection.Column
    }){
      routerPageTop({title:'注册'})//
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
          comInput({
            title:'确认密码',
            placeholder:'请确认密码',
            type:InputType.Password,
            value:$repeatinputpassword
          })
        }
        comButton({
          content:"注册并登陆",
          btntype:BtnType.Blue,
          isDisable:this.btnisdisable
        })
          .onChildTouchTest(()=>{
            if(!(this.inputnickname&&this.inputpassword&&this.repeatinputpassword)){
              console.log("密码和昵称不能为空")
              return { strategy: TouchTestStrategy.DEFAULT }
            }
            if(this.repeatinputpassword!==this.inputpassword){
              myShowToast('密码不一致')
              return { strategy: TouchTestStrategy.DEFAULT }
            }
            Register(this.inputnickname,this.inputpassword).then((res:AxiosResponse)=>{
              switch (res.data.status){
                case 0:
                  myShowToast('未知错误')
                  break
                case 1:
                  //将服务器返回的user_id存到本地
                  this.user_id=res.data.user_id
                  this.nickname=this.inputnickname
                  router.replaceUrl({url:'pages/Index'})
                  break
                case 2:
                  myShowToast('用户名已被占用')
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
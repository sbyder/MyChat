//发布moment弹窗
import { AxiosResponse } from '@ohos/axios'
import { BtnType } from '../../../../../common/enums/BtnType'
import { myShowToast } from '../../../../../common/utils/myShowToast'
import { postMoment } from '../../../../../http/Api'
import { comButton } from '../../../../commonView/comButton/comButton'

@CustomDialog
export struct postDialog {
  controller?: CustomDialogController

  inputcontent:string=''
  @State btnisdisable:boolean=true
  @StorageLink('user_id') user_id:number=22
  @Consume isrefresh:boolean
  build() {
    Column() {
      TextArea({placeholder:'这一刻的感受...'})
        .height('50%')
        .backgroundColor($r('app.color.grey'))
        .onChange((value:string)=>{
          this.btnisdisable=(value===''?true:false)
          this.inputcontent=value
      })
      Row(){
        Button({stateEffect:true}){
          Text('+')
            .fontSize(40)
            .fontColor(Color.White)
        }
          .type(ButtonType.Normal)
          .width(70)
          .height(70)
          .backgroundColor($r('app.color.grey'))
      }.width('100%')
      Row(){
        comButton({
          content:"发布",
          btntype:BtnType.Blue,
          routerinfo:"",
          isDisable:this.btnisdisable
        })
          .onChildTouchTest(() =>{
            if (this.controller != undefined) {
              if(!this.inputcontent)return { strategy: TouchTestStrategy.DEFAULT }
              postMoment(this.user_id,this.inputcontent).then((res:AxiosResponse)=>{
                switch (res.data.status){
                  case 0 :
                    this.isrefresh=true
                    this.controller?.close()
                    break
                  case 1:
                    myShowToast('未知错误')
                    break
                  default :
                    myShowToast('未知错误')
                }
              }).catch((err:string)=>{
                console.log(err)
              })

            }
            return { strategy: TouchTestStrategy.DEFAULT }
          })
      }
      .width('70%')
      .justifyContent(FlexAlign.Center)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .height('100%')
    .padding(10)
  }
}
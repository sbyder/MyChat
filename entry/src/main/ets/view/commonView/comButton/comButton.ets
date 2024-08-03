import router from '@ohos.router'

import { BtnType } from '../../../common/enums/BtnType'
import { parseRouterPathAndParams } from '../../../common/utils/parseRouterPathAndParams'

interface routerParams {
  title;
}

@Component
export struct comButton{
  @Prop content:string
  @Prop btntype:BtnType
  @Prop isDisable:boolean
  @Prop routerinfo: string
  @State routerpath:string=''
  @State routerparams: routerParams={title:''}
  //在页面渲染前获取routerpath和routerparams
  aboutToAppear(){
    if(!this.routerinfo)return
    let temp=parseRouterPathAndParams(this.routerinfo)
    this.routerpath=temp.routerpath
    this.routerparams=(temp.routerparams as routerParams)
  }
  build() {
    if(this.isDisable){
      Button(this.content)
        .comButtonStyle()
        .fontColor(Color.Gray)
        .backgroundColor("#E1E1E1")
        .stateEffect(false)
    }else {
      Button(this.content)
        .comButtonStyle()
        .fontColor(this.btntype===BtnType.Blue?'#fff':Color.Gray)
        .backgroundColor(this.btntype===BtnType.Blue?$r('app.color.theme_color'):'#fff')
        .onClick(()=>{
          router.pushUrl({
            url:this.routerpath,
            params:this.routerparams
          })
        })
    }
  }
}

@Extend(Button) function comButtonStyle(){
  .width("55%")
  .height(50)
  .type(ButtonType.Normal)
  .borderRadius(10)
  .fontSize(18)
}
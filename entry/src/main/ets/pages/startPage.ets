import { BtnType } from '../common/enums/BtnType'
import { comButton } from '../view/commonView/comButton/comButton'
import { router } from '@kit.ArkUI'

PersistentStorage.persistProps([
  { key: 'nickname', defaultValue: '未知用户' },
  { key: 'user_id', defaultValue: 0 }
])

@Entry
@Component
struct startPage {
  @StorageLink('user_id') user_id:number=0
  @StorageLink('nickname') nickname:string="未知用户"
  aboutToAppear(){
    if(this.user_id&&this.nickname!=="未知用户"){
      router.replaceUrl({url:'pages/Index'})
    }
  }
  build() {
    Flex({
      justifyContent: FlexAlign.SpaceAround,
      alignItems:ItemAlign.End
    }){
      Flex({justifyContent:FlexAlign.Center}){
        comButton({
          content:"登陆",
          btntype:BtnType.Blue,
          routerinfo:"pages/routerPages/startPages/loginPage?title=登陆"
        })
      }
      Flex({justifyContent:FlexAlign.Center}){
        comButton({
          content:"注册",
          btntype:BtnType.White,
          routerinfo:"pages/routerPages/startPages/registerPage?title=注册"
        })
      }

    }
    .width('100%')
    .height('100%')
    .padding({bottom:20})
    .backgroundImage($r('app.media.login_bg'))
    .backgroundImageSize({width: '100%'})
    .backgroundImagePosition(Alignment.Center)
    .linearGradient({colors:[["#000", 0.0],["#000", 0.5],["#000C15", 0.6]]})
    //背景色渐变使与背景图融为一体
  }
}


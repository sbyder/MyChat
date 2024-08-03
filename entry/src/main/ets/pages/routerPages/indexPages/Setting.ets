import { AxiosResponse } from '@ohos/axios'
import { ItemType } from '../../../common/enums/ItemType'
import { myShowToast } from '../../../common/utils/myShowToast'
import { Logout } from '../../../http/Api'
import { comItem } from '../../../view/commonView/comItem/comItem'
import { routerPageTop } from '../../../view/routerPages/routerPageTop'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct Setting{
  @StorageLink('user_id') user_id:number=0
  @StorageLink('nickname') nickname:string="未知用户"
  build() {
    Column(){
      routerPageTop({title:'设置'})
      Column(){
        comItem({title:'退出登录',itemtype:ItemType.Style2})
          .onClick(()=>{
            Logout(this.user_id).then((res:AxiosResponse)=>{
              switch (res.data.status){
                case 0:
                  this.user_id=0
                  this.nickname="未知用户"
                  router.replaceUrl({url:'pages/startPage'})
                  break
                case 1:
                  myShowToast('未知错误')
                  break
                default :
                  myShowToast('未知错误')
              }
            })
          })
      }
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.grey'))
  }
}
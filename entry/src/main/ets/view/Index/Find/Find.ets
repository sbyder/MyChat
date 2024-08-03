import { comItem } from '../../commonView/comItem/comItem'
import { router } from '@kit.ArkUI'

@Component
export struct Find{
  build() {
    Column(){
      comItem({ title: "朋友圈",
        iconSrc: $r('app.media.ic_moment')
      }).onChildTouchTest(()=>{
        router.pushUrl({url:'pages/routerPages/indexPages/Moments'})
        return { strategy: TouchTestStrategy.DEFAULT }
      })
    }.width('100%')
    .height('100%')
  }
}
import { Chat } from '../../../common/models/Chat'
import { msgItem } from './msgItem/msgItem'

@Component
export struct Msg{
  @StorageLink('chats') chats:Chat[]=[]
  build() {
    List(){
      ForEach(this.chats,(chat:Chat)=>{
        ListItem(){
          msgItem({ chat })
        }
      })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .divider({
      strokeWidth: 1,
      color: $r('app.color.grey'),
      startMargin: 80
    })
  }
}


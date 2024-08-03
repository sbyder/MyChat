import { User } from '../../../../common/models/User'
import { Avatar } from '../../../Avatar/Avatar'
import { perInfoDialog } from '../../../perInfoDialog/perInfoDialog'

@Component
export struct aListItem{
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: perInfoDialog({friend:this.friend}),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -20 },
    customStyle: false,
    cornerRadius: 20,
    width: 250,
    height: 200,
    backgroundColor: Color.Transparent,
    shadow: ({ radius: 0, color: '#B8BCC3', offsetX: 1, offsetY: 3}),
  })
  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }
  @Prop friend:User
  build() {
    ListItem(){
      Button({type: ButtonType.Normal, stateEffect: true}){
        Flex({justifyContent:FlexAlign.SpaceBetween,alignItems:ItemAlign.Center }){
          //avatar
          Avatar({content:this.friend.nickname})
            .width(50)
            .height(50)

          Text(this.friend.nickname)
            .padding(5)
            .margin({left:5})
            .fontSize(18)
          Blank()
        }
        .height('100%')
        .padding(10)
      }
      .height('70')
      .backgroundColor('#fff')
      .onClick(() => {
        if (this.dialogController != null) {
          this.dialogController.open()
        }
      })
    }
  }
}
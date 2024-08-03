import { postDialog } from './postDialog'

@Component
export struct postButton{
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: postDialog(),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -20 },
    customStyle: false,
    cornerRadius: 20,
    width: 300,
    height: 400,
    backgroundColor: Color.White,
    shadow: ({ radius: 0, color: '#B8BCC3', offsetX: 1, offsetY: 3}),
  })
  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }

  @Prop ismiddle:boolean
  build() {
    Button({stateEffect:true}){
      Text('+')
        .fontSize(25)
        .fontColor(this.ismiddle?'#000':'#fff')
        .animation({
          duration: 500,
        })
    }
    .width(30)
    .height(30)
    .border({width:1,color:this.ismiddle?'#000':'#fff'})
    .backgroundColor(Color.Transparent)
    .animation({
      duration: 500,
    })
    .onClick(() => {
      if (this.dialogController != null) {
        this.dialogController.open()
      }
    })
  }
}



@Component
export struct comInput{
  @Prop title:string
  @Prop placeholder:string
  @Prop type:InputType
  @Link value:string
  build() {
    Flex(){
      Flex({alignItems:ItemAlign.Center}){
        Text(this.title)
          .width(120)
          .fontSize(20)
        TextInput({ placeholder: this.placeholder })
          .type(this.type)
          .flexShrink(1)
          .backgroundColor('transparent')
          .fontSize(this.type===InputType.Password?15:20)
          .placeholderFont({size:20})
          .onChange((value)=>{
            this.value=value
          })
      }
      .width('100%')
      .height('100%')
      .padding({left:10,right:10})
      .border({width:{bottom:1},color:{bottom:'#ffcbcbcb'}})
    }
    .height(60)
    .padding({left:10,right:10})
  }
}
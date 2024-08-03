export class Tab{
  index:number
  title:string
  spell:string
  icon:Resource
  iconSelected:Resource
  constructor(index:number,title:string,spell:string) {
    this.index=index
    this.title=title
    this.spell=spell
    this.icon=$r(`app.media.${this.spell}`)
    this.iconSelected=$r(`app.media.${this.spell}_selected`)
  }
  isSelected(currentIndex:number){
    return this.index===currentIndex
  }
}
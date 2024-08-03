import { router } from '@kit.ArkUI'
import { Avatar } from '../../../view/Avatar/Avatar'
import { postButton } from '../../../view/Index/Find/Moments/postButton/postButton'
import { momentsList } from '../../../view/Index/Find/Moments/momentsList'
import { getMoments } from '../../../http/Api'
import { myShowToast } from '../../../common/utils/myShowToast'
import { Moment } from '../../../common/models/Moment'
import { AxiosResponse } from '@ohos/axios'


@Entry
@Component
struct Moments{
  @State moments:Moment[]=[]
  @Provide isrefresh:boolean=false
  yOffset:number=0
  @State ismiddle:boolean=false
  @StorageLink('nickname') nickname:string="未知用户"
  //获取moment函数
  pageGetMoments(){
    return getMoments().then((res:AxiosResponse)=>{
      switch (res.data.status){
        case 0:
          this.moments=res.data.results
          break
        case 2:
          myShowToast('未知错误')
          break
        default :
          myShowToast('未知错误')
      }
    })
  }
  onPageShow(){
    this.pageGetMoments()
  }
  build() {

    Column(){
      //顶部
      Flex(
        {
          justifyContent:FlexAlign.Center,
          alignItems: ItemAlign.Center
        }
      ){
        //返回箭头
        Text()
          .position({x:0,y:'50%'})
          .translate({y:'-50%'})
          .width(15)
          .height(15)
          .border({width:{left:1,bottom:1},color:this.ismiddle?'#000':"#fff"})
          .rotate({angle:45})
          .backgroundColor('transparent')
          .onClick(()=>{
            router.back()
          })
          .animation({
            duration: 500,
          })
        //标题
        Text("朋友圈")
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.ismiddle?'#000':Color.Transparent)
          .animation({
            duration: 500,
          })
        //post
        postButton({ismiddle:this.ismiddle})
          .position({x:'100%',y:'50%'})
          .translate({x:'-100%',y:'-50%'})
      }.width('100%')
      .height(50)
      .padding(10)
      .backgroundColor(this.ismiddle?$r('app.color.grey'):Color.Transparent)
      .position({y:0})
      .zIndex(1)
      .animation({
        duration: 500,
      })
      //双向绑定变量
      Refresh({refreshing:$$this.isrefresh }){
        Scroll(){
          Flex({direction:FlexDirection.Column}){

            //个人信息
            Column(){
              Image($r('app.media.default_bg'))
                .width('100%')
                .height(280)
              Row({space:5}){
                Text(this.nickname)
                  .padding({top:5})
                  .fontColor(Color.White)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                Flex(){
                  Avatar({content:this.nickname})
                }.width(70)
                .height(70)
              }
              .position({bottom:0})
              // .translate({y:'-50%'})
              .width('100%')
              .padding({right:15})
              .justifyContent(FlexAlign.End)
              .alignItems(VerticalAlign.Top)
              .backgroundColor(Color.Transparent)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
            .height(315)
            .backgroundColor(Color.White)
            // .backgroundImage($r('app.media.default_bg'))
            .backgroundImageSize({width:'100%'})
            .backgroundImagePosition({y:'-130%'})
            //moments列表
            momentsList({moments:this.moments})
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .onScrollFrameBegin((offset:number)=>{

          this.yOffset+=offset
          //个人信息-头像/2-顶部
          this.ismiddle=(this.yOffset>=352-35-50)
          return { offsetRemain: offset }
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Gray)
      .onRefreshing(async () => {
        await this.pageGetMoments()
        this.isrefresh = false
      })
    }
  }
}


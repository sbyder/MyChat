import { AxiosError, AxiosResponse } from '@ohos/axios'
import { User } from '../../../common/models/User'
import { myShowToast } from '../../../common/utils/myShowToast'
import { getFriends } from '../../../http/Api'
import {Avatar} from '../../Avatar/Avatar'
import { aListItem } from './aListItem/aListItem'

@Component
export struct addressList{
  @State sortedGroups:CapitalData[]=[]
  private scroller: Scroller = new Scroller()
  aboutToAppear(){
    getFriends().then((res:AxiosResponse)=>{
      switch (res.data.status){
        case 0:
          this.sortedGroups=res.data.sortedGroups
          break
        case 1:
          myShowToast('获取联系人失败')
        default :
          myShowToast('未知错误')
      }
    }).catch((err:AxiosError)=>{
      myShowToast(err.message)
    })
  }
  build() {
    //SideBarContainer接收两个组件:第一个为侧边栏,第二个为展示
    SideBarContainer(SideBarContainerType.Overlay){
      //侧边栏
      Column(){
        //回到顶部
        Text('↑')
          .fontSize(12)
          .fontColor(Color.Gray)
          .onClick(()=>{
            this.scroller.scrollEdge(Edge.Top)
          })
        //字母索引列表
        ForEach(this.sortedGroups,(sortedGroup:CapitalData,index:number)=>{
          Text(sortedGroup.capital)
            .fontSize(12)
            .fontColor(Color.Gray)
            .onClick(()=>{
              //接口列表列表作为第一个ListItemGroup占了index0,故需+1
              this.scroller.scrollToIndex(index+1,true)
            })
        })
      }
      .justifyContent(FlexAlign.Center)
      // .border({width:0,color:Color.Transparent})
      .backgroundColor(Color.Transparent)

      List({scroller:this.scroller}){
        //接口列表
        ListItemGroup(){
          ListItem(){
            Button({type: ButtonType.Normal, stateEffect: true}){
              Flex({justifyContent:FlexAlign.SpaceBetween,alignItems:ItemAlign.Center }){
                //avatar
                Flex(){
                  Avatar({content:$r('app.media.xindepengyou')})
                }.width(50)
                .height(50)

                Text('新的朋友')
                  .padding(5)
                  .margin({left:5})
                  .fontSize(18)
                Blank()
              }
              .height('100%')
              .padding(10)
            }
            .height('80')
            .backgroundColor('#fff')

          }
        }
        //联系人列表
        ForEach(this.sortedGroups,(sortedGroup:CapitalData)=>{
          ListItemGroup({header:this.ListItemGroupHead(sortedGroup.capital)}){
            ForEach(sortedGroup.users,(friend:User)=>{
              aListItem({friend})
            })
          }.divider({
            strokeWidth:2,
            startMargin:60
          })
          .id(`grouphead${sortedGroup.capital}`)
        })
      }
      .width(('100%'))
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .showControlButton(false)
    .sideBarWidth(20)
    .sideBarPosition(SideBarPosition.End)
  }
  @Builder ListItemGroupHead(title:string){
    Text(title)
      .width('100%')
      .height(20)
      .padding({left:10})
      .backgroundColor(Color.Transparent)
  }
}



interface CapitalData {
  capital: string;
  users: User[];
}
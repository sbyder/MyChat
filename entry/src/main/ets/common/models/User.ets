export class User{
  user_id:number=0
  nickname:string='未知用户'
  avatar:string|Resource=this.nickname[0]
  surname:string

  constructor(avatar?:Resource) {
    this.surname=this.nickname[0]
    //typeof avatar返回的是字符串类型, 即typeof avatar===undefined永远不返回true
    this.avatar=typeof avatar==='undefined'?this.surname:(avatar as Resource)
  }
}
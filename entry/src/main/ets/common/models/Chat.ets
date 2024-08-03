import { User } from './User';

export class Chat {
  chat_id: number=0
  join_users: number[]=[]
  preview: string=''
  timestamp: number=0
  friend: User=new User()
  unread_amount:number=0

  constructor() {

  }
}
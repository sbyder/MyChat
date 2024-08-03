import { AxiosResponse } from '@ohos/axios'
import {instance} from './Axios'

export function Login(nickname:string,password:string) {
  return instance.post('/users/login',{nickname,password});
}
export function Register(nickname:string,password:string) {
  return instance.post('/users/register',{nickname,password});
}
export function getFriends() {
  return instance.get('/users/getfriends');
}
export function Logout(user_id:number) {
  return instance.post('/users/logout',{user_id});
}
export function searchUserbyID(user_id:number) {
  return instance.get('/users/searchuserbyid',{params:{user_id}});
}


export function getMoments() {
  return instance.get('/moments/getmoments');
}
export function postMoment(user_id:number,content:string) {
  return instance.post('/moments/postmoment',{user_id,content});
}


export function createChat(join_users:number[]) {
  return instance.post('/chats/createchat',{join_users});
}
export function getChats(user_id:number) {
  return instance.get('/chats/getchats',{params:{user_id}});
}

export function getMessages(chat_id:number) {
  return instance.get('/messages/getmessages',{params:{chat_id}});
}
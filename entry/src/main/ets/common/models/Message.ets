

export class Message {
  chat_id: number;
  send_user_id: number;
  receive_user_id: number;
  content: string;
  timestamp: number;

  constructor(
    chat_id: number,
    send_user_id: number,
    receive_user_id:number,
    content: string,
    timestamp: number) {
    this.send_user_id=send_user_id
    this.receive_user_id=receive_user_id
    this.chat_id=chat_id
    this.content=content
    this.timestamp=timestamp
  }
}
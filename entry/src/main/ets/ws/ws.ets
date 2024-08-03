import webSocket from '@ohos.net.webSocket';

const user_id=AppStorage.get<number>('user_id')

const defaultIpAddress = `ws://mychat.cwpblog.xyz?user_id=${user_id}`;
let ws = webSocket.createWebSocket();

ws.on('close', (err, value) => {
  console.log("on close, code is " + value.code + ", reason is " + value.reason);
});
ws.on('error', (err) => {
  console.log("on error, error:" + JSON.stringify(err));
});
ws.connect(defaultIpAddress, (err, value) => {
  if (!err) {
    console.log("connect success");
  } else {
    console.log("connect fail, err:" + JSON.stringify(err));
  }
});

export {ws}

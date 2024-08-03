import promptAction from '@ohos.promptAction'

export function myShowToast(content:string){
  promptAction.showToast({
    message:content,
    duration:2000,
    alignment:Alignment.Center
  })
}
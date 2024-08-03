export const stampToTime = (timestamp) => {
  // 时间戳为10位需*1000，时间戳为13位不需乘1000
  let date = new Date(parseInt(timestamp))
  let Y = date.getFullYear()
  let M = date.getMonth() + 1
  let D = date.getDate()
  let h = date.getHours()
  let m = date.getMinutes()

  let nowdate = new Date()
  let nY = nowdate.getFullYear()
  let nM = nowdate.getMonth() + 1
  let nD = nowdate.getDate()
  let nh = nowdate.getHours()
  let nm = nowdate.getMinutes()

  if (Y === nY) {
    if (M === nM) {
      if (D === nD) {
        if (m === nm) {
          return '刚刚'
        }
        return `${mendZero(h)}:${mendZero(m)}`
      } else if (D + 1 === nD) {
        return `昨天 ${mendZero(h)}:${mendZero(m)}`
      }
    }
    return `${M}月${D}日 ${mendZero(h)}:${mendZero(m)}`
  }
  return `${Y}年${M}月${D}日 ${mendZero(h)}:${mendZero(m)}`
}
//补零
let mendZero = (num) => {
  return num < 10 ? "0" + num : num
}
import axios from '@ohos/axios'

//创建axios实例
export const instance = axios.create({
  baseURL: 'https://mychat.cwpblog.xyz/',
  timeout: 1000
})


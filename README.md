# MyChat

## 1 简介

基于ArkTS+Node的即时通信软件

## 2 特性

- 登录注册
- 即时通信
- 朋友圈

## 3 预览

1. 起始页

   <img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240802193250373.png" alt="image-20240802193250373" style="zoom:50%;" />

2. 登陆/注册页

   <img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240802193359571.png" alt="image-20240802193359571" style="zoom:50%;" /><img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240802193414850.png" alt="image-20240802193414850" style="zoom:50%;" />

3. 主页

   <img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240802193458251.png" alt="image-20240802193458251" style="zoom:50%;" /><img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240802193512065.png" alt="image-20240802193512065" style="zoom:50%;" /><img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240802193544303.png" alt="image-20240802193544303" style="zoom:50%;" /><img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240802193715192.png" alt="image-20240802193715192" style="zoom:50%;" />

4. 朋友圈

   <img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240802194202153.png" alt="image-20240802194202153" style="zoom:50%;" />
   
5. 聊天窗口

   <img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240803155006336.png" alt="image-20240803155006336" style="zoom:50%;" />

## 4 功能模块

### 4.1 登录/注册

- 校验

- 节流

- 用户状态管理

  | status | 状态       |
  | ------ | ---------- |
  | 0      | 未登录     |
  | 1      | 已登录在线 |
  | 2      | 已登录离线 |

### 4.2 即时通信

- 消息缓存

一条消息的生命周期

<img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240803054719828.png" alt="image-20240803054719828" style="zoom:67%;" />

### 4.3 朋友圈

- 发布朋友圈

  <img src="C:\Users\22592\AppData\Roaming\Typora\typora-user-images\image-20240803151647027.png" alt="image-20240803151647027" style="zoom:50%;" />

- 下拉刷新/上划加载
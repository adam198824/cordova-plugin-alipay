# cordova-plugin-adam-alipay

### 前言：

此版本是基于cordova-plugin-gubnoi-alipay的bug修改
###### 本插件仅支持《APP支付》，不支持移动支付

***

### 功能说明

1. 根据支付宝的说明文档的建议，为保证安全，签名都放到后端去做，前端只需要接收后台传入签名字符串，使用该插件调用支付宝SDK完成支付
2. APP_ID：对应开放平台中应用的APPID，主要用于iOS平台xcode构建URL Schemes

***

### 支持平台

1. android （alipaySdk-20180601.jar）
2. iOS

##### note：xcode版本须大于7.0

***
### 安装
###### 在线安装
    ionic cordova plugin add cordova-plugin-adam-alipay --variable APP_ID=[your AppId]
    cordova plugin add https://github.com/adam198824/cordova-plugin-alipay --variable APP_ID=[your AppId]

###### 本地安装
下载插件到本地

    cordova plugin add /your/local/path --variable APP_ID=[your AppId]
    
***
### 使用 API
   
###### 第一步：订单在服务端签名生成订单信息，具体请参考官网进行签名处理 https://docs.open.alipay.com/204/105465/

    var payInfo = "app_id=2015052600090779&biz_content=%7B%22timeout_express%22%3A%2230m%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A%220.01%22%2C%22subject%22%3A%221%22%2C%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22IQJZSRC1YMQB5HU%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fdomain.merchant.com%2Fpayment_notify&sign_type=RSA2&timestamp=2016-08-25%2020%3A26%3A31&version=1.0&sign=cYmuUnKi5QdBsoZEAbMXVMmRWjsuUj%2By48A2DvWAVVBuYkiBj13CFDHu2vZQvmOfkjE0YqCUQE04kqm9Xg3tIX8tPeIGIFtsIyp%2FM45w1ZsDOiduBbduGfRo1XRsvAyVAv2hCrBLLrDI5Vi7uZZ77Lo5J0PpUUWwyQGt0M4cj8g%3D";

######  第二步：调用支付插件 
    1.declare let Alipay;

    Alipay.pay(data,success,error);

     //response.resultStatus  状态代码  e.result  本次操作返回的结果数据 e.memo 提示信息
     //response.resultStatus  9000  订单支付成功 ;8000 正在处理中  调用function success
     //response.resultStatus  4000  订单支付失败 ;6001  用户中途取消 ;6002 网络连接出错  调用function error
     //当response.resultStatus为9000时，请去服务端验证支付结果
                /**
                 * 同步返回的结果必须放置到服务端进行验证（验证的规则请看https://doc.open.alipay.com/doc2/
                 * detail.htm?spm=0.0.0.0.xdvAU6&treeId=59&articleId=103665&
                 * docType=1) 建议商户依赖异步通知
                 */
                

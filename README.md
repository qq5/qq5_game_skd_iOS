
# 一.配置要求
支持iOS8.0及以上版本

# 二.开发环境搭建 
## 1.build Setting设置
### 1.1、Bitcode设置 不支持Bitcode,在工程中将Enable Bitcode 设为 No.
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/Bitcode.png)
### 1.2 设置Other Linker Flags
支付SDK中有使用到Category，所以请在工程中设置Other Linker Flags包含-ObjC，否则会造成运行时无法加载Category中方法的崩溃问题.
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/Flags.png)
### 1.3 info设置
#### 1.3.1、相册权限设置
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/相册权限.png)

#### 1.3.2、支付相关设置
##### a.配置支付相关的 URLTypes
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/pay.png)
#### b.添加支付相关的白名单
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>alipayqr</string>
    <string>alipay</string>
    <string>alipayshare</string>
    <string>alipays</string>
    <string>weixin</string>
    <string>wechat</string>
</array>
```
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/白名单.png)

#### 1.3.3 、添加SDK文件
##### a、添加QQ5SDK和第三方文件
添加SDK和Lib下所有文件
##### b、添加依赖的系统库
CoreTelephony.framework、CoreMotion.framework、libz.tbd、libsqlite3.tbd、libc++.tbd、
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/framework.png)

#### 1.3.4、在AppDelegate里添加：
```
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskAll;
}
```

摇一摇相关代码：
```
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //检测到摇动开始
    
    if (motion == UIEventSubtypeMotionShake) {
        
    }
    
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动取消
    
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        [[QQ5SDK shareInstance]resetMenuView:YES];
        
    }
    
}
```

# 三、启动SDK
## 1、设置SDK信息
```
/*
 初始化
 * @param appId 在QQ5游戏中心申请的appId
 * @param appKey 在QQ5游戏中心申请的appKey
 * @param gameChannel 在QQ5游戏的渠道号
 */

- (void)initSDKWithAppId:(NSString *)appId
              WithAppKey:(NSString *)appKey
             gameChannel:(NSString *)gameChannel
           loginCallBack:(void(^)(id data))block;
接入示例：
[[QQ5SDK shareInstance] initSDKWithAppId:@"1" WithAppKey:@"H0ndi0tBTq" gameChannel:@"1_1" loginCallBack:^(id data) {

}];
```
## 2、用户登录
```
/*
 用户登录
 * @param block 登录完毕回调接口
 
 */
-(void)startSDKLoginCallBlock:(void(^)(id data))block;
接入示例：
[[QQ5SDK shareInstance] startSDKLoginCallBlock:^(id data) {


}];
```
## 3、进入游戏
```
/*
 进入游戏
 * @param roleId 游戏角色id
 * @param roleName 游戏角色名称
 * @param roleLevel 游戏角色等级
 * @param serverId 服务器id
 * @param serverName 服务器名称
 * @param enterGameCallBack 进入游戏回调接口
 
 */
-(void)enterGameRoleId:(NSString *)roleId roleName:(NSString *)roleName roleLevel:(NSString *)roleLevel serverId:(NSString *)serverId serverName:(NSString *)serverName enterGameCallBack:(void (^)(id data))block;
接入示例：
[[QQ5SDK shareInstance]enterGameRoleId:@"123" roleName:@"123" roleLevel:@"123" serverId:@"123" serverName:@"123" enterGameCallBack:^(id data) {

}];
```
## 4、支付接口（必接）

```
/*
 支付接口（必接）
 * 拉起支付界面，注册支付回调监听器。
 * @param amout 充值金额须大于0.1，支持一位小数（单位：元）
 * @param gameCoin 游戏币数量(1)
 * @param gameCoinName 游戏币名称
 * @param gameOrderId 游戏订单id
 * @param extra 透传字段（SDK服务端回调原样返回）
 * @param productId 内购产品Id
 * @param payCallBack 支付回调接口
 */


-(void)initUserPayViewAmout:(NSString *)amout gameCoin:(NSString *)gameCoin gameCoinName:(NSString *)gameCoinName gameOrderId:(NSString *)gameOrderId extra:(NSString *)extra withProductId:(NSString *)productId payCallBack:(void (^)(id data))block;

接入示例：

 [[QQ5SDK shareInstance]resetMenuView:NO];
 NSDate *date = [NSDate date];
 [[QQ5SDK shareInstance] initUserPayViewAmout:@"6" gameCoin:@"600" gameCoinName:@"金币" gameOrderId:[NSString stringWithFormat:@"%f_",[date timeIntervalSince1970]] extra:@"dasfdjaslkfjdsaklfjdslakf" withProductId:@"com.qq5SDK.num1" payCallBack:^(id data) {
 
 }];
 ```

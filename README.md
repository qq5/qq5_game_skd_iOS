# qq5_game_skd_iOS
一.配置要求<br>
支持iOS8.0及以上版本<br>
二.开发环境搭建<br>
1.build Setting设置<br>
1.1、Bitcode设置 不支持Bitcode,在工程中将Enable Bitcode 设为 No.<br>
<br>
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/Bitcode.png)
<br>
1.2 设置Other Linker Flags<br>
支付SDK中有使用到Category，所以请在工程中设置Other Linker Flags包含-ObjC，否则会造成运行时无法加载Category中方法的崩溃问题.<br>
<br>
<br>
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/Flags.png)
<br>
<br>
1.3 info设置<br>
1.3.1、相册权限设置<br>
<br>
<br>
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/相册权限.png)
<br>
<br>
1.3.2、支付相关设置<br>
a.配置支付相关的 URLTypes<br>
<br>
<br>
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/pay.png)
<br>
<br>
b.添加支付相关的白名单<br>

\<key\>LSApplicationQueriesSchemes\<\/key\>
\<array\><br>
    \<string\>alipayqr\<\/string\><br>
    \<string\>alipay\<\/string\><br>
    \<string\>alipayshare\<\/string\><br>
    \<string\>alipays\<\/string\><br>
    \<string\>weixin\<\/string\><br>
    \<string\>wechat\<\/string\><br>
\<\/array\><br>
<br>
<br>
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/白名单.png)
<br>
<br>
1.3.3 、添加SDK文件<br>
a、添加QQ5SDK和第三方文件<br>
添加SDK和Lib下所有文件<br>
b、添加依赖的系统库<br>
CoreTelephony.framework、CoreMotion.framework、libz.tbd、libsqlite3.tbd、libc++.tbd、<br>
<br>
<br>
![](https://github.com/qq5/qq5_game_skd_iOS/blob/master/images/framework.png)
<br>
<br>
1.3.4、在AppDelegate里添加：<br>
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{<br>
    
    return UIInterfaceOrientationMaskAll;
}<br>



摇一摇相关代码：<br>
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event<br>

{<br>
    
    //检测到摇动开始
    
    if (motion == UIEventSubtypeMotionShake) {
        
    }
    
}<br>

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event<br>

{<br>
    
    //摇动取消
    
}<br>

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event<br>

{<br>
    
    //摇动结束<br>
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        [[QQ5SDK shareInstance]resetMenuView:YES];
        
    }
    
}<br>

三、启动SDK<br>
1、设置SDK信息<br>
/*<br>
 初始化<br>
 * @param appId 在QQ5游戏中心申请的appId<br>
 * @param appKey 在QQ5游戏中心申请的appKey<br>
 * @param gameChannel 在QQ5游戏的渠道号<br>
 */<br>

- (void)initSDKWithAppId:(NSString *)appId<br>
              WithAppKey:(NSString *)appKey<br>
             gameChannel:(NSString *)gameChannel<br>
           loginCallBack:(void(^)(id data))block;<br>
接入示例：<br><br>

    [[QQ5SDK shareInstance] initSDKWithAppId:@"1" WithAppKey:@"H0ndi0tBTq" gameChannel:@"1_1" loginCallBack:^(id data) {
        

    }];

2、<br>
/*<br>
 用户登录<br>
 * @param block 登录完毕回调接口<br>
 
 */<br>
(void)startSDKLoginCallBlock:(void(^)(id data))block;<br>
接入示例：<br>

        [[QQ5SDK shareInstance] startSDKLoginCallBlock:^(id data) {
            NSLog(@"%@",data);


        }];

3、/*<br>
 进入游戏<br>
 * @param roleId 游戏角色id<br>
 * @param roleName 游戏角色名称<br>
 * @param roleLevel 游戏角色等级<br>
 * @param serverId 服务器id<br>
 * @param serverName 服务器名称<br>
 * @param enterGameCallBack 进入游戏回调接口<br>
 
 */<br>
(void)enterGameRoleId:(NSString *)roleId roleName:(NSString *)roleName roleLevel:(NSString *)roleLevel serverId:(NSString *)serverId serverName:(NSString *)serverName enterGameCallBack:(void (^)(id data))block;
接入示例：<br>
        [[QQ5SDK shareInstance]enterGameRoleId:@"123" roleName:@"123" roleLevel:@"123" serverId:@"123" serverName:@"123" enterGameCallBack:^(id data) {


        }];

4、<br>
/*<br>
 支付接口（必接）<br>
 * 拉起支付界面，注册支付回调监听器。<br>
 * @param amout 充值金额须大于0.1，支持一位小数（单位：元）<br>
 * @param gameCoin 游戏币数量(1)<br>
 * @param gameCoinName 游戏币名称<br>
 * @param gameOrderId 游戏订单id<br>
 * @param extra 透传字段（SDK服务端回调原样返回）<br>
 * @param productId 内购产品Id<br>
 * @param payCallBack 支付回调接口<br>
 */<br>


-(void)initUserPayViewAmout:(NSString *)amout gameCoin:(NSString *)gameCoin gameCoinName:(NSString *)gameCoinName gameOrderId:(NSString *)gameOrderId extra:(NSString *)extra withProductId:(NSString *)productId payCallBack:(void (^)(id data))block;

接入示例：<br>

        [[QQ5SDK shareInstance]resetMenuView:NO];
        NSDate *date = [NSDate date];
        [[QQ5SDK shareInstance] initUserPayViewAmout:@"6" gameCoin:@"600" gameCoinName:@"金币" gameOrderId:[NSString stringWithFormat:@"%f_",[date timeIntervalSince1970]] extra:@"dasfdjaslkfjdsaklfjdslakf" withProductId:@"com.qq5SDK.num1" payCallBack:^(id data) {

        }];

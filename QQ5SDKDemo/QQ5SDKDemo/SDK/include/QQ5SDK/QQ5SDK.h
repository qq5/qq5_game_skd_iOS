//
//  QQ5SDK.h
//  QQ5SDK
//
//  Created by 魅游 on 17/6/26.
//  Copyright © 2017年 XHP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QQ5SDKResult) {
    QQ5SDKResultSuccess          = 0,     // 成功
    QQ5SDKResultFail             = 1,     // 失败
    QQ5SDKResultDealing          = 2,     //处理中
    QQ5SDKResultCancel           = 3,     //取消
    QQ5SDKResultError            = 4,     // 用户录入信息有误、等一般性错误，
    QQ5SDKResultUnknown          = 5      //获取支付结果失败，当出现这种状态时，需要商户APP主动向商户服务器发起查询请求。
} ;
typedef void(^loginSuccessBlock)(NSDictionary *data);

@interface QQ5SDK : NSObject
/**
 初始化SDK
 
 @return QQ5SDK类
 */
+ (instancetype)shareInstance;

/*
 初始化
 * @param appId 在QQ5游戏中心申请的appid
 * @param appKey 在QQ5游戏中心申请的appkey
 * @param gameChannel 在QQ5游戏的渠道号
 */

- (void)initSDKWithAppId:(NSString *)appId
              WithAppKey:(NSString *)appKey
             gameChannel:(NSString *)gameChannel
           loginCallBack:(void(^)(id data))block;
/*
 用户登录
 * @param block 登录完毕回调接口
 
 */
- (void)startSDKLoginCallBlock:(void(^)(id data))block;

/*
 进入游戏
 * @param roleId 游戏角色id
 * @param roleName 游戏角色名称
 * @param roleLevel 游戏角色等级
 * @param serverId 服务器id
 * @param serverName 服务器名称
 * @param enterGameCallBack 进入游戏回调接口
 
 */
- (void)enterGameRoleId:(NSString *)roleId roleName:(NSString *)roleName roleLevel:(NSString *)roleLevel serverId:(NSString *)serverId serverName:(NSString *)serverName enterGameCallBack:(void (^)(id data))block;
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
/**
 设置isHorizontal 是否横屏显示 默认值为YES
 */
@property (nonatomic, assign) BOOL isHorizontal;
@property (nonatomic, assign) BOOL isAutoLogin;


- (void)resetMenuView:(BOOL)type;
@end

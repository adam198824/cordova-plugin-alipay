#import "Alipay.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation Alipay

@synthesize appId, callbackId;

-(void)pluginInitialize
{
    self.appId = [[self.commandDelegate settings] objectForKey:@"app_id"];
}

- (void)pay:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    NSString* orderString = [command.arguments objectAtIndex:0];

    // if (!orderString) {
    //     [self.commandDelegate sendPluginResult:[CDVPluginResult initWithStatus:CDVCommandStatus_ERROR message:orderString] 
    //         callbackId:self.callbackId];
    // }
    if ([self.appId length] == 0)
    {
        [self failWithCallbackID:self.callbackId withMessage:@"支付APP_ID设置错误"];
        return;
    }

    NSString* appScheme = [NSString stringWithFormat:@"ali%@", self.appId];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        [self successWithCallbackID:self.callbackId messageAsDictionary:resultDic];
    }];
}
- (void)handleOpenURL:(NSNotification *)notification
{
    NSURL* url = [notification object];
    
    if ([url.scheme rangeOfString:self.appId].length > 0)
    {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self successWithCallbackID:self.callbackId messageAsDictionary:resultDic];
        }];
    }
}

- (void)successWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    NSLog(@"message = %@",message);
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    NSLog(@"message = %@",message);
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)successWithCallbackID:(NSString *)callbackID messageAsDictionary:(NSDictionary *)message
{
    NSLog(@"message = %@",message);
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID messageAsDictionary:(NSDictionary *)message
{
    NSLog(@"message = %@",message);
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}
@end
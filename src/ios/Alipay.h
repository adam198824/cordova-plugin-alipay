#import <Cordova/CDV.h>

@interface Alipay : CDVPlugin 
@property(nonatomic,strong)NSString *appId;
@property(nonatomic,strong)NSString *callbackId;

- (void)pay:(CDVInvokedUrlCommand*)command;
@end
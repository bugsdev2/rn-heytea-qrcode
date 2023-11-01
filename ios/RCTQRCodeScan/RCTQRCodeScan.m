//
//  RCTQRCodeScan.m
//  heyteago
//
//  Created by 肖怡宁 on 2020/6/3.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "RCTQRCodeScan.h"
#import "HQRCodeVc.h"

@implementation RCTQRCodeScan

RCT_EXPORT_MODULE(HeyTeaQRCode);

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup  {
    return YES;
}

- (instancetype)init {

    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendEventWithInfo:) name:@"QRCodeInfoNotification" object:nil];
    }
    return self;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"ScanQRCodeInfoNotification"];
}

- (void)sendEventWithInfo:(NSNotification *)notification {
    [self sendEventWithName:@"ScanQRCodeInfoNotification" body:notification.userInfo];
}

//扫码
RCT_EXPORT_METHOD(scanQRCode:(NSString *)lang) {

    HQRCodeVc *qrVc = [[HQRCodeVc alloc] init];
    qrVc.lang = lang;
    
    [[RCTQRCodeScan getRootNavVc] pushViewController:qrVc animated:YES];

}

//获得当前导航控制器
+ (UINavigationController *)getRootNavVc {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    return (UINavigationController *)window.rootViewController;
}


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end

//
//  DJIDRootViewController.m
//  DJIDebuger
//
//  Created by DJI on 15/10/13.
//  Copyright © 2015年 DJI. All rights reserved.
//

#import "DJIDRootViewController.h"
#import <DJISDK/DJISDK.h>
#include <pthread.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

#define weakSelf(__TARGET__) __weak typeof(self) __TARGET__=self
#define weakReturn(__TARGET__) if(__TARGET__==nil)return;

#define DJI_SERVICE_OPTION_KEY @"DJI_SERVICE_OPTION_KEY"
#define DJI_DEBUG_ID_NAME_KEY @"DJI_DEBUG_ID_NAME_KEY"

#define GREEN_IMAGE_1 [UIImage imageNamed:@"icon_circle_green_1"]
#define GREEN_IMAGE_2 [UIImage imageNamed:@"icon_circle_green_2"]
#define RED_IMAGE_1 [UIImage imageNamed:@"icon_circle_red_1"]
#define RED_IMAGE_2 [UIImage imageNamed:@"icon_circle_red_2"]

@interface DJIDRootViewController ()<DJISDKDebugServerDelegate>

@property (assign,nonatomic) pthread_mutex_t serviceMutex;

// UI
@property (weak,nonatomic) IBOutlet UILabel* debugIdLabel;
@property (weak,nonatomic) IBOutlet UILabel* debugTitleLabel;

@property (weak,nonatomic) IBOutlet UIImageView* rcImageView1;
@property (weak,nonatomic) IBOutlet UIImageView* rcImageView2;

@property (weak,nonatomic) IBOutlet UIImageView* wifiImageView1;
@property (weak,nonatomic) IBOutlet UIImageView* wifiImageView2;

@end

@implementation DJIDRootViewController

- (void) updateIPAddress:(NSString*) ipaddress {
    weakSelf(target);
    dispatch_async(dispatch_get_main_queue(), ^{
        weakReturn(target);
        target.debugIdLabel.text = ipaddress;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pthread_mutex_init(&_serviceMutex, NULL);
    
    [self initUI];
    
    weakSelf(target);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakReturn(target);
        [DJISDKManager  startSDKDebugServerWithCompletion:^(NSString* ipaddress){
            [target updateIPAddress:ipaddress];
        }];
        [DJISDKManager setDebugServerDelegate:target];
    });
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void) dealloc
{
    pthread_mutex_destroy(&_serviceMutex);
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

-(void) initUI
{
    [self setWiFiConnectionStatus:NO];
    [self setRCConnectionStatus:NO];
    
    self.debugIdLabel.text = @"";

}

-(void) setRCConnectionStatus:(BOOL)connected
{
    if (connected) {
        self.rcImageView1.image = GREEN_IMAGE_1;
        self.rcImageView2.image = GREEN_IMAGE_2;
    }
    else
    {
        self.rcImageView1.image = RED_IMAGE_1;
        self.rcImageView2.image = RED_IMAGE_2;
    }
}

-(void) setWiFiConnectionStatus:(BOOL)connected
{
    if (connected) {
        self.wifiImageView1.image = GREEN_IMAGE_1;
        self.wifiImageView2.image = GREEN_IMAGE_2;
    }
    else
    {
        self.wifiImageView1.image = RED_IMAGE_1;
        self.wifiImageView2.image = RED_IMAGE_2;
    }
}

#pragma mark - UI Action

-(IBAction) onResetButtonClicked:(id)sender
{
    [self setWiFiConnectionStatus:NO];
    weakSelf(target);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakReturn(target);
        [DJISDKManager setDebugServerDelegate:target];
        [DJISDKManager startSDKDebugServerWithCompletion:^(NSString * ipaddress){
            [target updateIPAddress:ipaddress];
        }];
    });
}

-(void) sdkDebugServerWithRCConnectionStatus:(BOOL)isRCConnected andDebugClientConnectionStatus:(BOOL)isWifiConnected{

    weakSelf(target);
    dispatch_async(dispatch_get_main_queue(), ^{
        weakReturn(target);
        [target setRCConnectionStatus:isRCConnected];
        [target setWiFiConnectionStatus:isWifiConnected];
    });

}

@end

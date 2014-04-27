//
//  AppDelegate.h
//  MeetYou
//
//  Created by tianliwei on 26/4/14.
//  Copyright (c) 2014 tianliwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "RegisterViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *naviVC;

@end

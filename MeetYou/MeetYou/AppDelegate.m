//
//  AppDelegate.m
//  MeetYou
//
//  Created by tianliwei on 26/4/14.
//  Copyright (c) 2014 tianliwei. All rights reserved.
//

#import "AppDelegate.h"
#import "UserInfoViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaAppKey];
    //[[UIBarButtonItem appearance] setTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    self.naviVC = [[UINavigationController alloc]initWithRootViewController:registerVC];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.naviVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    if ([request isKindOfClass:WBAuthorizeRequest.class]) {
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc]init];
        NSString *userid = [(WBAuthorizeResponse *)response userID];
        NSString *weiboToken = [(WBAuthorizeResponse *)response accessToken];
        NSString *userInfoUrl = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&access_token=%@",userid,weiboToken];//
        userInfoVC.userInfoUrl = userInfoUrl;
        [self.naviVC pushViewController:userInfoVC animated:YES];
    }
}

@end

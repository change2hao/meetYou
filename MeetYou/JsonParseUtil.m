//
//  JsonParseUtil.m
//  MeetYou
//
//  Created by tianliwei on 26/4/14.
//  Copyright (c) 2014 tianliwei. All rights reserved.
//

#import "JsonParseUtil.h"

@implementation JsonParseUtil

+ (NSString *)parseGender:(NSString *)letter{
    if ([letter isEqualToString:@"m"]) {
        return @"男";
    }else if ([letter isEqualToString:@"f"]){
        return @"女";
    }else{
        return @"未知";
    }
}

+ (UserInfo *)getUserInfo:(NSData *)userInfoData{
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:userInfoData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"UserInfoDic:%@\n",dic);
    UserInfo *userInfo = [[UserInfo alloc]init];
    userInfo.nickName = dic[@"screen_name"];
    userInfo.signature = dic[@"description"];
    userInfo.avatorUrl = dic[@"profile_image_url"];
    userInfo.gender = [self parseGender:dic[@"gender"]];
    userInfo.location = dic[@"location"];
    return userInfo;
}

@end

//
//  JsonParseUtil.h
//  MeetYou
//
//  Created by tianliwei on 26/4/14.
//  Copyright (c) 2014 tianliwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
@interface JsonParseUtil : NSObject

+ (UserInfo *)getUserInfo:(NSData *)userInfoData;

@end

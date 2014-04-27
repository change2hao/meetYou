//
//  Macro.h
//  MeetYou
//
//  Created by tianliwei on 26/4/14.
//  Copyright (c) 2014 tianliwei. All rights reserved.
//

#ifndef MeetYou_Macro_h
#define MeetYou_Macro_h

#define kSinaAppKey @"2137058799"
#define kSinaRedirectURI @"https://api.weibo.com/oauth2/default.html"


////////////////////////////////////////////

#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
#define UI_SCREEN_WIDTH                 320
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_APPFRAME_HEIGHT              ([[UIScreen mainScreen] applicationFrame].size.height)
#define UI_NAVIFRAME_HEIGHT             ([[UIScreen mainScreen] applicationFrame].size.height-UI_NAVIGATION_BAR_HEIGHT)


#endif

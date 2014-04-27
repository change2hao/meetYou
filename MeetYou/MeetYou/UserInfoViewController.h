//
//  UserInfoViewController.h
//  MeetYou
//
//  Created by tianliwei on 26/4/14.
//  Copyright (c) 2014 tianliwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *userInfoTableView;
@property (nonatomic, copy) NSString *userInfoUrl;
@end

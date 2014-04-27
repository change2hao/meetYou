//
//  UserInfoViewController.m
//  MeetYou
//
//  Created by tianliwei on 26/4/14.
//  Copyright (c) 2014 tianliwei. All rights reserved.
//

#import "UserInfoViewController.h"
#import "JsonParseUtil.h"
#import "UserInfoCell.h"
#import "UserInfoAvatorCell.h"
#import "CoverSettingsViewController.h"
#import "UserInfo.h"
@interface UserInfoViewController ()
@property (nonatomic, strong)NSArray *userInfos;
@property (nonatomic, strong)UserInfo *userInfo;
@property (nonatomic, strong)UIActivityIndicatorView *webLoading;
@end

static NSString *userInfoCellIdentifier = @"UserInfoCell";
static NSString *userInfoAvatorCellIdentifier = @"UserInfoAvatorCell";

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userInfos = @[@"头像",@"名字",@"性别",@"地区",@"签名"];
    }
    return self;
}

- (void)requestUserInfo{
    NSURL *url = [NSURL URLWithString:[self.userInfoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:15];
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
                               //block define statment
                               NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                               NSLog(@"response status code is %d",[httpResponse statusCode]);
                               
                               if (error) {
                                   
                                   NSLog(@"%@",error);//从缓存获取
                                   
                               }else if ([data length] == 0 && error == nil){
                                   
                                   NSLog(@"=========No data========");//没有数据
                                   
                               }else{
                                   
                                   self.userInfo = [JsonParseUtil getUserInfo:data];
                                   [self.userInfoTableView reloadData];
                                   
                               }
                               
                               [self.webLoading removeFromSuperview];
                               
                           }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO];
    
    //下一步按钮
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBackgroundColor:[UIColor clearColor]];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    nextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    nextButton.frame = CGRectMake(0.0f, 0.0f, 60.0f, 25.0f);
    UIBarButtonItem *nextButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.rightBarButtonItem = nextButtonItem;
    
    self.webLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.webLoading.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_NAVIFRAME_HEIGHT);
    [self.webLoading startAnimating];
    [self.view addSubview:self.webLoading];
    
    //注册Cell
    [self.userInfoTableView registerNib:[UINib nibWithNibName:@"UserInfoCell" bundle:nil] forCellReuseIdentifier:userInfoCellIdentifier];
    [self.userInfoTableView registerNib:[UINib nibWithNibName:@"UserInfoAvatorCell" bundle:nil] forCellReuseIdentifier:userInfoAvatorCellIdentifier];
    [self requestUserInfo];
}

- (void)nextStep:(UIButton *)button{
    CoverSettingsViewController *converVC = [[CoverSettingsViewController alloc]init];
    [self.navigationController pushViewController:converVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userInfos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100.0f;
    }else{
        return 55.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UserInfoAvatorCell *avatorCell = [tableView dequeueReusableCellWithIdentifier:userInfoAvatorCellIdentifier];
        avatorCell.mainLabel.text = self.userInfos[indexPath.row];
        [avatorCell.avator setImageWithURL:[NSURL URLWithString:self.userInfo.avatorUrl]];
        return avatorCell;
    }else{
        UserInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:userInfoCellIdentifier];
        infoCell.mainLabel.text = self.userInfos[indexPath.row];
        switch (indexPath.row) {
            case 1:
                infoCell.subLabel.text = self.userInfo.nickName;
                break;
            case 2:
                infoCell.subLabel.text = self.userInfo.gender;
                break;
            case 3:
                infoCell.subLabel.text = self.userInfo.location;
                break;
            case 4:
                infoCell.subLabel.text = self.userInfo.signature;
                break;
            default:
                break;
        }
        return infoCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

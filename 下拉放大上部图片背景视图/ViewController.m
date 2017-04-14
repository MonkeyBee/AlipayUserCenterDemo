//
//  ViewController.m
//  下拉放大上部图片背景视图
//
//  Created by wubing on 2017/4/14.
//  Copyright © 2017年 wubing. All rights reserved.
//

#import "ViewController.h"

NSInteger const backHeight = 200;
NSInteger const headerWidth = 120;
NSInteger const headerHeight = 120;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIImageView *_backImageView;
    UIImageView *_headImageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 头像
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, headerHeight)];
    _headImageView.image = [UIImage imageNamed:@"img2"];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview:_headImageView];
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImageView.layer.borderWidth = 2;
    

    // 注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    // 设置tableView偏移
    _tableView.contentInset = UIEdgeInsetsMake(backHeight, 0, 0, 0);
    
    // 设置背景和头像位置
    dispatch_async(dispatch_get_main_queue(), ^{
        // 个人信息
        UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 100)];
        _tableView.tableHeaderView = infoView;
        
        // 背景
        CGRect tmpRect = _backImageView.frame;
        tmpRect.origin.y = -backHeight;
        _backImageView.frame = tmpRect;
        
        // 头像
        _headImageView.center = CGPointMake(_tableView.frame.size.width / 2.0, 0);
    });
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -backHeight) {
        CGRect rect = _backImageView.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        _backImageView.frame = rect;
    }
}

@end

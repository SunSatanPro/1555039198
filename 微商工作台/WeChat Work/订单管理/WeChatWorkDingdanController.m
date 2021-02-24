//
//  WeChatWorkDingdanController.m
//  Wechat Treasure
//
//  Created by 卫宫巨侠欧尼酱 on 2021/2/1.
//  Copyright © 2021 SK. All rights reserved.
//

#import "WeChatWorkDingdanController.h"
#import "WeChatWorkAddDingdanController.h"


@interface WeChatWorkDingdanCell ()
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkTitle;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkName;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkPhone;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkPrice;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkDate;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkKuaidi;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkLocation;

@end

@implementation WeChatWorkDingdanCell
//@[@"标题",@"价格",@"姓名",@"电话",@"时间",@"快递编号",@"地址"]

- (void)awakeFromNib {
    self.back.layer.shadowColor = SKThemeColor.CGColor;
}

- (void)WeChatWorkUpdate:(NSArray *)WeChatWorkInfo {
    self.WeChatWorkTitle.text = WeChatWorkInfo[0];
    self.WeChatWorkPrice.text = WeChatWorkInfo[1];
    self.WeChatWorkName.text = WeChatWorkInfo[2];
    self.WeChatWorkPhone.text = WeChatWorkInfo[3];
    self.WeChatWorkDate.text = WeChatWorkInfo[4];
    self.WeChatWorkKuaidi.text = WeChatWorkInfo[5];
    self.WeChatWorkLocation.text = WeChatWorkInfo[6];
}

@end


@interface WeChatWorkDingdanController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (strong ,nonatomic) NSMutableArray *WeChatWorkData;

@end

@implementation WeChatWorkDingdanController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self WeChatWorkSetupData];
}

- (void)WeChatWorkSetupData {
    self.WeChatWorkData = [NSMutableArray array];
    [self.WeChatWorkData addObjectsFromArray:SKUserGet(@"WeChatWorkDingdanData")];
    [self.tableView reloadData];
}

- (IBAction)WeChatWorkAdd:(id)sender {
//    [WeChatWorkAddDingdanController push:^(NSArray * _Nullable data) {
//        [self.WeChatWorkData addObject:data];
//        [self.tableView reloadData];
//    }];
    [self presentViewController:[WeChatWorkAddDingdanController push:^(NSArray * _Nullable data) {
        [self.WeChatWorkData addObject:data];
        [self.tableView reloadData];
    }] animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.WeChatWorkData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeChatWorkDingdanCell *WeChatWorkDingdanCell = [tableView dequeueReusableCellWithIdentifier:@"WeChatWorkDingdanCell"];
    WeChatWorkDingdanCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [WeChatWorkDingdanCell WeChatWorkUpdate:self.WeChatWorkData[indexPath.row]];
    
    return WeChatWorkDingdanCell;
}

//iOS11之后侧滑删除-支持设置图片【设置后iOS11优先走这里，与上面不冲突】
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [SKT remove:self.WeChatWorkData[indexPath.row] Key:@"WeChatWorkDingdanData"];
        [self.WeChatWorkData removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if (!self.WeChatWorkData.count) {
            [tableView reloadEmptyDataSet];
        }
        
        completionHandler (YES);
    }];
    if (@available(iOS 13.0, *)) {
        deleteRowAction.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        deleteRowAction.backgroundColor = [UIColor whiteColor];
    }
    
    deleteRowAction.image = [[UIImage systemImageNamed:@"trash.fill"] initwithColor:SKThemeColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    text = @"空数据";
    font = SKTitleFont(17);
    textColor = [UIColor colorWithHex:@"545454"];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    text = @"数据为空，请点击右上角按钮添加数据";
    font = SKTitleFont(15);
    textColor = [UIColor colorWithHex:@"545454"];
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.navigationController.navigationBar.barTintColor range:[attributedString.string rangeOfString:@"添加数据"]];
    
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIImage imageNamed:@"icon-1"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    text = @"添加数据";
    font = SKTitleFont(15);
    textColor = self.navigationController.navigationBar.barTintColor;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self WeChatWorkAdd:nil];
}


@end

//
//  WeChatWorkPassWordController.m
//  SK Utility
//
//  Created by 卫宫巨侠欧尼酱 on 2020/9/1.
//  Copyright © 2020 SK. All rights reserved.
//

#import "WeChatWorkPassWordController.h"
#import "WeChatWorkPasswordCell.h"

@interface WeChatWorkPassWordController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (strong ,nonatomic) NSMutableArray *WeChatWorkData;

@end

@implementation WeChatWorkPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号管理";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.WeChatWorkData = [NSMutableArray array];
    [self.WeChatWorkData addObjectsFromArray:SKUserGet(@"WeChatWorkPassWord")];
    [self.tableView reloadData];
}

- (IBAction)WeChatWorkPassWordAdd:(id)sender {
    [self showADComplete:^{
        SCLAlertView *WeChatWorkalert = [[SCLAlertView alloc] init];
        
        WeChatWorkalert.customViewColor = self.navigationController.navigationBar.barTintColor;
        
        SCLTextView *WeChatWorktext1 = [WeChatWorkalert addTextField:@"账号信息"];
        SCLTextView *WeChatWorktext2 = [WeChatWorkalert addTextField:@"密码信息"];
        WeChatWorktext1.textAlignment = NSTextAlignmentCenter;
        WeChatWorktext2.textAlignment = NSTextAlignmentCenter;
        WeChatWorktext1.textColor = self.navigationController.navigationBar.barTintColor;
        WeChatWorktext2.textColor = self.navigationController.navigationBar.barTintColor;
        
        [WeChatWorkalert addButton:@"确认" actionBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SKT checkError:@[WeChatWorktext1,WeChatWorktext2] Title:@"添加账号" Contents:@[@"账号",@"密码"] ReInfo:NO Block:^(id  _Nullable object) {
                    [self.WeChatWorkData addObject:@{WeChatWorktext1.text:WeChatWorktext2.text}];
                    SKUserSet(@"WeChatWorkPassWord", self.WeChatWorkData);
                    [self.tableView reloadData];
                }];
            });
        }];
        
        [WeChatWorkalert showEdit:self.navigationController title:@"提醒" subTitle:@"请输入账号和密码" closeButtonTitle:@"取消" duration:0.0f];
    }];
}


#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.WeChatWorkData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeChatWorkPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeChatWorkPasswordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.WeChatWorkPasswordAC.text = ((NSDictionary *)self.WeChatWorkData[indexPath.row]).allKeys.firstObject;
    cell.WeChatWorkPasswordPS.text = ((NSDictionary *)self.WeChatWorkData[indexPath.row]).allValues.firstObject;
    
    cell.nav = self.navigationController;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.WeChatWorkData removeObjectAtIndex:indexPath.row];
        
        SKUserSet(@"WeChatWorkPassWord", self.WeChatWorkData);
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if (!self.WeChatWorkData.count) {
            [tableView reloadEmptyDataSet];
        }
    }
}

//iOS11之后侧滑删除-支持设置图片【设置后iOS11优先走这里，与上面不冲突】
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [self.WeChatWorkData removeObjectAtIndex:indexPath.row];
        
        SKUserSet(@"WeChatWorkPassWord", self.WeChatWorkData);
        
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
    deleteRowAction.image = [[UIImage imageNamed:@"delete"] initwithColor:self.navigationController.navigationBar.barTintColor];
    
    
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
    font = [UIFont fontWithName:@"System-Heavy" size:17];
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
    
    text = @"数据为空，请点击右上角进行添加数据";
    font = [UIFont systemFontOfSize:15];
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
    
    text = [NSString stringWithFormat:@"添加 %@ 数据",@"密码"];
    font = [UIFont systemFontOfSize:20 weight:15];
    textColor = self.navigationController.navigationBar.barTintColor;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self WeChatWorkPassWordAdd:nil];
}

@end

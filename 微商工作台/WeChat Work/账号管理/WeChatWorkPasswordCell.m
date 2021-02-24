//
//  WeChatWorkPasswordCell.m
//  SK Utility
//
//  Created by 卫宫巨侠欧尼酱 on 2020/9/1.
//  Copyright © 2020 SK. All rights reserved.
//

#import "WeChatWorkPasswordCell.h"

@implementation WeChatWorkPasswordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (IBAction)WeChatWorkPassword1:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.WeChatWorkPasswordAC.text;
    SCLAlertView *alert = [[SCLAlertView  alloc] init];
    alert.showAnimationType = 0;
    alert.customViewColor = SKThemeColor;
    [alert showTitle:self.nav title:@"提醒" subTitle:@"账号信息已复制" style:(2) closeButtonTitle:nil duration:1.0f];
}

- (IBAction)WeChatWorkPassword2:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.WeChatWorkPasswordPS.text;
    SCLAlertView *alert = [[SCLAlertView  alloc] init];
    alert.showAnimationType = 0;
    alert.customViewColor = SKThemeColor;
    [alert showTitle:self.nav title:@"提醒" subTitle:@"密码信息已复制" style:(2) closeButtonTitle:nil duration:1.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

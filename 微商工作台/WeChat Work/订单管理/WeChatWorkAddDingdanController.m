//
//  WeChatWorkAddDingdanController.m
//  Wechat Treasure
//
//  Created by 卫宫巨侠欧尼酱 on 2021/2/1.
//  Copyright © 2021 SK. All rights reserved.
//

#import "WeChatWorkAddDingdanController.h"
#import "WSDatePickerView.h"

@interface WeChatWorkAddDingdanController ()

@property (weak, nonatomic) IBOutlet UIView *back;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *WeChatWorkContents;
@property (weak, nonatomic) IBOutlet UITextView *WeChatWorkLocation;

@property (strong ,nonatomic) SKDataBlock block;

@end

@implementation WeChatWorkAddDingdanController

+ (WeChatWorkAddDingdanController *)push:(SKDataBlock)block {
    WeChatWorkAddDingdanController *replyAddController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeChatWorkAddDingdanController"];
    replyAddController.block = block;
    return replyAddController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.back.layer.shadowColor = SKThemeColor.CGColor;
    ((UIView *)self.WeChatWorkContents[4]).layer.borderColor = [UIColor colorWithHex:@"dddddd"].CGColor;
    ((UIView *)self.WeChatWorkContents[6]).layer.borderColor = [UIColor colorWithHex:@"dddddd"].CGColor;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectTime:(UIButton *)sender {
    
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        [sender setTitle:dateString forState:UIControlStateSelected];
        sender.selected = YES;
    }];
    
    datepicker.dateLabelColor  = SKThemeColor;//年-月-日-时-分 颜色
    datepicker.doneButtonColor = SKThemeColor;//确定按钮的颜色
    
    [datepicker show];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"地址信息"]) {
        textView.text = nil;
        textView.textColor = SKThemeColor.dark;
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (!textView.text.length) {
        textView.text = @"地址信息";
        
        textView.textColor = UIColor.lightGrayColor;
    }
    
    return YES;
}

- (IBAction)casdjkan:(id)sender {
    if ([self.WeChatWorkLocation.text isEqualToString:@"地址信息"]) {
        [SKT showInfo:SKInfoTypeNotice content:@"请输入地址信息" block:nil];
        return;
    }
    
    [SKT checkError:self.WeChatWorkContents Title:@"添加订单信息" Contents:@[@"标题",@"价格",@"姓名",@"电话",@"时间",@"快递编号",@"地址"] ReInfo:NO Block:^(id  _Nullable object) {
        [SKT save:object Key:@"WeChatWorkDingdanData"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.block(object);
        });
    }];
    
    [self dismiss:nil];
}

@end

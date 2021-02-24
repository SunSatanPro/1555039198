//
//  WeChatWorkAddCodeController.m
//  QRBAR CODE
//
//  Created by 卫宫巨侠欧尼酱 on 2021/1/23.
//  Copyright © 2021 SK. All rights reserved.
//

#import "WeChatWorkAddCodeController.h"
#import "WeChatWorkManager.h"

@interface WeChatWorkAddCodeController ()

@property (weak, nonatomic) IBOutlet UILabel *codeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *type;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *confirm;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (strong ,nonatomic) SKNormalBlock block;


@property (assign ,nonatomic) BOOL QR;

@end

@implementation WeChatWorkAddCodeController

+ (void)push:(BOOL)QR block:(SKNormalBlock)block {
    WeChatWorkAddCodeController *WeChatWorkAddCodeController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeChatWorkAddCodeController"];
    WeChatWorkAddCodeController.QR = QR;
    WeChatWorkAddCodeController.block = block;
    
    [[SKT currentVC] presentViewController:WeChatWorkAddCodeController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeView.layer.shadowColor = SKThemeColor.CGColor;
    self.type.layer.borderColor = [UIColor colorWithHex:@"dddddd"].CGColor;
    self.content.layer.borderColor = [UIColor colorWithHex:@"dddddd"].CGColor;
    if (!self.QR) {
        self.codeTitle.text = @"添加条形码";
        self.name.placeholder = @"条形码标题";
        self.content.text = @"条形码内容";
        self.codeTitle.textColor = [UIColor colorNamed:@"TextColor"];
        self.content.textColor = [UIColor colorNamed:@"TextColor"];
        self.name.textColor = [UIColor colorNamed:@"TextColor"];
        
        [self.back setTintColor:[UIColor colorNamed:@"TextColor"]];
        self.codeView.backgroundColor = [UIColor colorNamed:@"TextColor"];
        [self.type setTitleColor:[UIColor colorNamed:@"TextColor"] forState:UIControlStateSelected];
        [self.confirm setTitleColor:[UIColor colorNamed:@"TextColor"] forState:UIControlStateNormal];
        
        SKUserSet(@"SKCurrentColor", @"43d6ff");
    } else {
        
        SKUserSet(@"SKCurrentColor", @"182966");
    }
}

- (IBAction)selectType:(UIButton *)sender {
    [SKSheetView show:@"选择类型" sheets:@[@"文本",@"名片",@"电话",@"邮箱",@"账号",@"购物",@"位置",@"收藏",@"记录"] isColor:YES block:^(NSInteger index, NSString * _Nullable content) {
        sender.selected = YES;
        sender.tag = index;
        [sender setTitle:content forState:UIControlStateSelected];
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (self.QR) {
        if ([textView.text isEqualToString:@"二维码内容"]) {
            textView.text = nil;
            textView.textColor = SKThemeColor;
        }
    } else {
        if ([textView.text isEqualToString:@"条形码内容"]) {
            textView.text = nil;
            textView.textColor = [UIColor colorNamed:@"TextColor"];
        }
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (self.QR) {
        if (!textView.text.length) {
            textView.text = @"二维码内容";
            
            textView.textColor = UIColor.lightGrayColor;
        }
        [self QRCODE];
    } else {
        if (!textView.text.length) {
            textView.text = @"条形码内容";
            
            textView.textColor = UIColor.lightGrayColor;
        }
        [self BARCODE];
    }
    
    return YES;
}

- (void)QRCODE {
    __block NSString *text = self.content.text;
    __block CGSize size = self.image.bounds.size;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *code = text.length? text: self.name.placeholder;
        UIImage *codeImage = [WeChatWorkManager generateQRCode:code size:size];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image.image = codeImage;
            self.image.tag = 1;
        });
    });
}

- (void)BARCODE {
    __block NSString *text = self.content.text;
    __block CGSize size = self.image.bounds.size;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *code = text.length? text: self.name.placeholder;
        UIImage *codeImage = [WeChatWorkManager generateCode128:code size:size];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image.image = codeImage;
            self.image.tag = 1;
        });
    });
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirm:(id)sender {
    if (self.QR) {
        if ([self.content.text isEqualToString:@"二维码内容"]) {
            [SKT showInfo:SKInfoTypeNotice content:@"请输入二维码内容" block:nil];
            return;
        }
    } else {
        if ([self.content.text isEqualToString:@"条形码内容"]) {
            [SKT showInfo:SKInfoTypeNotice content:@"请输入条形码内容" block:nil];
            return;
        }
    }
    
    [SKT checkError:@[self.image,self.name,self.type,self.content] Title:self.codeTitle.text Contents:@[@"图片",@"标题",@"类型",@"内容"] ReInfo:NO Block:^(id  _Nullable object) {
        if (self.QR) {
            [SKT save:object Key:@"QRCODEDATA"];
        } else {
            [SKT save:object Key:@"BARCODEDATA"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.block();
        });
        [self dismiss:nil];
    }];
}

@end

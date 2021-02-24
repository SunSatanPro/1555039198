//
//  WeChatWorkShuiyinController.m
//  WeChatWork
//
//  Created by 卫宫巨侠欧尼酱 on 2021/1/28.
//  Copyright © 2021 SK. All rights reserved.
//

#import "WeChatWorkShuiyinController.h"
#import "WatermarkView.h"

@interface WeChatWorkShuiyinController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIStackView *WeChatWorkStack;
@property (weak, nonatomic) IBOutlet UITextField *waterContent;

@property (strong ,nonatomic) UIImage *currentImage;
@property (assign ,nonatomic) BOOL AllFull;

@end

@implementation WeChatWorkShuiyinController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentImage = [UIImage imageNamed:@"logo"];
}

- (IBAction)WeChatWorkAddImage:(id)sender {
    [SKT selectImage:nil Block:^(UIImage * _Nullable image, NSString * _Nullable imageUrl) {
        
        UIImageView *WeChatWorkDetailImage = self.WeChatWorkStack.arrangedSubviews[0];
        [WeChatWorkDetailImage removeFromSuperview];
        WeChatWorkDetailImage.image = image;
        self.currentImage = image;
        [self.WeChatWorkStack addArrangedSubview:WeChatWorkDetailImage];
        [WeChatWorkDetailImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(image.size.height/image.size.width*self.WeChatWorkStack.frame.size.width);
            [self.WeChatWorkStack layoutIfNeeded];
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.AllFull) {
                [self WeChatWorkAllFull:nil];
            } else {
                [self WeChatWorkWater:nil];
            }
        });
    }];
}

- (IBAction)WeChatWorkRefresh:(id)sender {
    self.waterContent.text = nil;
    [self WeChatWorkWater:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.AllFull) {
            [self WeChatWorkAllFull:nil];
        } else {
            [self WeChatWorkWater:nil];
        }
    });
    
    return YES;
}

- (IBAction)WeChatWorkWater:(id)sender {
    self.AllFull = NO;
    UIImageView *imageView = self.WeChatWorkStack.arrangedSubviews[0];
    imageView.image = [WatermarkView TopRightMarkImage:self.currentImage andTitle:(self.waterContent.text.length?self.waterContent.text:@"请输入水印内容") andMarkFont:SKTitleFont(self.currentImage.size.width/20) andMarkColor:[self.currentImage.color checkColor:[UIColor colorWithRed:152./255.f green:152./255.f blue:152./255.f alpha:.25]]];
}

- (IBAction)WeChatWorkAllFull:(id)sender {
    self.AllFull = YES;
    UIImageView *imageView = self.WeChatWorkStack.arrangedSubviews[0];
    imageView.image = [WatermarkView FullWaterMarkImage:self.currentImage andTitle:(self.waterContent.text.length?self.waterContent.text:@"请输入水印内容") andMarkFont:SKTitleFont(self.currentImage.size.width/25) andMarkColor:[self.currentImage.color checkColor:[UIColor colorWithRed:152./255.f green:152./255.f blue:152./255.f alpha:.25]]];
}

- (IBAction)WeChatWorkSave:(id)sender {
    UIImageView *imageView = self.WeChatWorkStack.arrangedSubviews[0];
    UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

//指定回调方法
- (void)image: (UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (image == nil) {
        return;
    }
    NSString *msg = @"保存图片成功";
    if(error != NULL){
        msg = @"保存图片失败" ;
        [SKT showInfo:SKInfoTypeInfo content:msg block:nil];
        return;
    }
    [SKT showInfo:SKInfoTypeInfo content:msg block:^(BOOL completed) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    NSLog(@"🌹🌹🌹🌹%@",msg);
}


@end

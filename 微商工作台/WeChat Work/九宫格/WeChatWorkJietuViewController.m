//
//  WeChatWorkJietuViewController.m
//  Picture Edward
//
//  Created by 卫宫巨侠欧尼酱 on 2021/2/5.
//  Copyright © 2021 SK. All rights reserved.
//

#import "WeChatWorkJietuViewController.h"

@interface WeChatWorkJietuViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *WeChatWorkStack;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkZong;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkHeng;

@property (strong ,nonatomic) UIImage *WeChatWorkImage;
@property (strong ,nonatomic) NSMutableArray *WeChatWorkImages;

@end

@implementation WeChatWorkJietuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.WeChatWorkImages = [NSMutableArray array];
}

- (void)WeChatWorkUpdate {
    NSInteger zong = self.WeChatWorkZong.text.integerValue;
    NSInteger heng = self.WeChatWorkHeng.text.integerValue;
    
    CGFloat pieceImageWidh = self.WeChatWorkImage.size.width / heng;
    CGFloat pieceImageHeight = self.WeChatWorkImage.size.width / zong;
    [self.WeChatWorkImages removeAllObjects];
    for (UIView *WeChatWorkView in self.WeChatWorkStack.arrangedSubviews) {
        WeChatWorkView.hidden = YES;
        [WeChatWorkView removeFromSuperview];
    }
    for (NSInteger row = 0; row < zong; row ++) {
        for (NSInteger col = 0; col < heng; col ++) {
            UIStackView *stack;
            if (!col) {
                stack = [[UIStackView alloc] init];
                stack.spacing = 2;
                stack.axis = UILayoutConstraintAxisHorizontal;
                stack.distribution = UIStackViewDistributionFillEqually;
                [self.WeChatWorkStack addArrangedSubview:stack];
            } else {
                stack = self.WeChatWorkStack.arrangedSubviews[row];
            }
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            CGRect rect = CGRectMake(col * pieceImageWidh, row * pieceImageHeight, pieceImageWidh, pieceImageHeight);
            CGImageRef imgRef = CGImageCreateWithImageInRect(self.WeChatWorkImage.CGImage, rect);
            UIImage * image = [UIImage imageWithCGImage:imgRef];
            
            imageView.image = image;
            [stack addArrangedSubview:imageView];
            if (image) {
                [self.WeChatWorkImages addObject:image];
            }
        }
    }
}

- (IBAction)WeChatWorkSave:(id)sender {
   
   for (UIImage *item in self.WeChatWorkImages) {
       UIImageWriteToSavedPhotosAlbum(item, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
   }

   [SKT showInfo:SKInfoTypeLoding content:@"切图保存成功！" block:^(BOOL completed) {
       [self.navigationController popViewControllerAnimated:YES];
   }];
}

//指定回调方法
- (void)image: (UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (image == nil) {
        return;
    }
    NSString *msg = @"保存图片成功";
    if(error != NULL){
        msg = @"保存图片失败" ;
//        [SKT showInfo:SKInfoTypeInfo content:msg block:nil];
        return;
    }
    NSLog(@"🌹🌹🌹🌹%@",msg);
}

- (IBAction)WeChatWorkSelectImage:(UIButton *)sender {
    [SKT selectImage:nil Block:^(UIImage * _Nullable image, NSString * _Nullable imageUrl) {
        self.WeChatWorkImage = image.square;
        [sender setTitle:nil forState:UIControlStateNormal];
        [self WeChatWorkUpdate];
    }];
}

- (IBAction)WeChatWorkJiaJians:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {
            if (self.WeChatWorkZong.text.integerValue > 1) {
                self.WeChatWorkZong.text = @(self.WeChatWorkZong.text.integerValue-1).stringValue;
            }
        }
            break;
        case 1: {
            if (self.WeChatWorkZong.text.integerValue < 9) {
                self.WeChatWorkZong.text = @(self.WeChatWorkZong.text.integerValue+1).stringValue;
            }
        }
            break;
        case 2: {
            if (self.WeChatWorkHeng.text.integerValue > 1) {
                self.WeChatWorkHeng.text = @(self.WeChatWorkHeng.text.integerValue-1).stringValue;
            }
        }
            break;
        case 3: {
            if (self.WeChatWorkHeng.text.integerValue < 9) {
                self.WeChatWorkHeng.text = @(self.WeChatWorkHeng.text.integerValue+1).stringValue;
            }
        }
            break;
            
        default:
            break;
    }
    
    [self WeChatWorkUpdate];
}


@end

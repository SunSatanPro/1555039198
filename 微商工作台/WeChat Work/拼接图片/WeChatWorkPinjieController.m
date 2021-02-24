//
//  WeChatWorkPinjieController.m
//  WeChatWork
//
//  Created by 卫宫巨侠欧尼酱 on 2021/1/27.
//  Copyright © 2021 SK. All rights reserved.
//

#import "WeChatWorkPinjieController.h"

@interface WeChatWorkPinjieController ()

@property (weak, nonatomic) IBOutlet UIStackView *WeChatWorkStack;
@property (weak, nonatomic) IBOutlet UIScrollView *WeChatWorkScrollView;
@property (weak, nonatomic) IBOutlet UILabel *trmark;

@end

@implementation WeChatWorkPinjieController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)WeChatWorkAddImage:(id)sender {
    [SKT selectImage:nil Block:^(UIImage * _Nullable image, NSString * _Nullable imageUrl) {
        self.trmark.hidden = YES;
        UIImageView *WeChatWorkDetailImage = [[UIImageView alloc] init];
        WeChatWorkDetailImage.image = image;
        [self.WeChatWorkStack addArrangedSubview:WeChatWorkDetailImage];
        [WeChatWorkDetailImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(image.size.height/image.size.width*self.WeChatWorkStack.frame.size.width);
            [self.WeChatWorkStack layoutIfNeeded];
        }];
    }];
}

- (IBAction)WeChatWorkSlider:(UISlider *)sender {
    self.WeChatWorkStack.spacing = sender.value;
    [self.WeChatWorkStack layoutIfNeeded];
}

- (IBAction)WeChatWorkSave:(id)sender {
    [self saveImageToPhotoAlbum:self.WeChatWorkScrollView.snapshotScrollView];
}

#pragma mark - 保存至相册

- (void)saveImageToPhotoAlbum:(UIImage*)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
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

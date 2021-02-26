//
//  SMJADRedPacketViewController.m
//  Demo
//
//  Created by SunSatan on 2021/2/23.
//

#import "SMJADRedPacketViewController.h"
#import "SMJAD.h"
#import <Masonry/Masonry.h>

@interface SMJADRedPacketViewController ()

@property (nonatomic, strong) UIImageView *redPacket;
@property (nonatomic, strong) UIImageView *cancel;

@end

@implementation SMJADRedPacketViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:30/255.f green:30/255.f blue:30/255.f alpha:0.7];
    [self.view ss_addAction:^{
        [self showAd];
    }];
    
    self.redPacket = UIImageView.new;
    self.redPacket.image = [UIImage imageNamed:@"smjad_icon_redpacket"];
    [self.redPacket ss_addAction:^{
        [self showAd];
    }];
    [self.view addSubview:self.redPacket];
    [self.redPacket mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        CGFloat height = (self.view.bounds.size.width - 80)/self.redPacket.image.size.width*self.redPacket.image.size.height;
        make.height.mas_equalTo(height);
    }];
    
    AdBannerHeadView *bannerAd = [AdBannerHeadView.alloc initWithRootViewController:self];
    bannerAd.backgroundColor = UIColor.clearColor;
    [self.view addSubview:bannerAd];
    [bannerAd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(bannerAd.size.height);
    }];
    
    self.cancel = UIImageView.new;
    self.cancel.image = [UIImage imageNamed:@"smjad_icon_close"];
    [self.cancel ss_addAction:^{
        [self showAd];
    }];
    [self.view addSubview:self.cancel];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(20);
        make.top.mas_equalTo(bannerAd.mas_bottom).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
    }];
}

- (void)showAd {
    [self showADComplete:^{
        [self dismissViewControllerAnimated:NO completion:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否跳转抖音领取红包？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [UIApplication.sharedApplication openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id1142110895"]];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self.presentingViewController presentViewController:alert animated:YES completion:nil];
    }];
}

@end

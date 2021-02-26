//
//  SMJADSecondViewController.m
//  Demo
//
//  Created by SunSatan on 2021/2/23.
//

#import "SMJADSecondViewController.h"
#import "SMJAD.h"
#import <Masonry/Masonry.h>

@interface SMJADSecondViewController ()

@end

@implementation SMJADSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBarHidden = YES;
    
    AdBannerHeadView *bannerAd = [AdBannerHeadView.alloc initWithRootViewController:self];
    bannerAd.backgroundColor = UIColor.clearColor;
    [self.view addSubview:bannerAd];
    [bannerAd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(bannerAd.size.height);
    }];
    
    UIImageView *homeImage = UIImageView.new;
    homeImage.contentMode = UIViewContentModeScaleAspectFit;
    [homeImage ss_setImageWithURL:[NSString stringWithFormat:@"%@",SMJADmanager.share.expandInfo[@"second_image"]]];
    [homeImage ss_addAction:^{
        [self nextBtnAction];
    }];
    [self.view addSubview:homeImage];
    [homeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bannerAd.mas_top);
    }];
}

- (void)nextBtnAction {
    [self showADComplete:^{
        [self.navigationController pushViewController:SMJADThirdViewController.new animated:YES];
    }];
}


@end

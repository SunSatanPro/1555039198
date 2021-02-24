//
//  WeChatWorkPreviewView.h
//  QiQRCode
//
//  Created by huangxianshuai on 2018/11/13.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WeChatWorkPreviewView;
@protocol WeChatWorkPreviewViewDelegate <NSObject>

- (void)codeScanningView:(WeChatWorkPreviewView *)scanningView didClickedTorchSwitch:(UIButton *)switchButton;

@end

@interface WeChatWorkPreviewView : UIView

@property (nonatomic, assign, readonly) CGRect rectFrame;
@property (nonatomic, weak) id<WeChatWorkPreviewViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame rectColor:(UIColor *)rectColor;
- (instancetype)initWithFrame:(CGRect)frame rectColor:(UIColor *)rectColor;
- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame;

- (void)startScanning;
- (void)stopScanning;
- (void)startIndicating;
- (void)stopIndicating;
- (void)showTorchSwitch;
- (void)hideTorchSwitch;

@end

NS_ASSUME_NONNULL_END

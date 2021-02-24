//
//  WatermarkView.h
//  Demo
//
//  Created by yanglin on 2018/8/14.
//  Copyright © 2018 yanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WatermarkView : UIImageView
/**
 设置水印
 
 @param frame 水印大小
 @param markText 水印显示的文字
 */
+ (UIImage *)imageWithFrame:(CGRect)frame Image:(UIImage *)image WithText:(NSString *)markText;
+ (UIImage *)FullWaterMarkImage: (UIImage *)originalImage andTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor;
+ (UIImage *)TopRightMarkImage: (UIImage *)originalImage andTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor;

@end

NS_ASSUME_NONNULL_END

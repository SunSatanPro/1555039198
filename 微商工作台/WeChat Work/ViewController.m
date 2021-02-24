//
//  ViewController.m
//  WeChat Work
//
//  Created by 卫宫巨侠欧尼酱 on 2021/2/23.
//

#import "ViewController.h"
#import "WaterRippleAndView.h"
#import "WeChatWorkDATAController.h"
#import "WeChatWorkDingdanController.h"
#import "WeChatWorkShuiyinController.h"
#import "WeChatWorkPinjieController.h"
#import "WeChatWorkPassWordController.h"
#import "WeChatWorkDATAController.h"
#import "WeChatWorkJietuViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *WaterRippleBack;
@property (weak, nonatomic) IBOutlet UIView *WeChatWorkCount;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *WeChatWorkViews;
@property (weak, nonatomic) IBOutlet UILabel *WeChatWorkNumber;

@property (nonatomic, strong) WaterRippleAndView *BackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIView *view in self.WeChatWorkViews) {
        view.layer.shadowColor = SKThemeColor.CGColor;
    }
    
    [self.WaterRippleBack addSubview:self.BackView];
    //第一步，通过UIBezierPath设置圆形的矢量路径
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SKWidth*0.7/2-75.0f, SKWidth*0.7/2-75, 150, 150)];
    //第二步，用CAShapeLayer沿着第一步的路径画一个完整的环（颜色灰色，起始点0，终结点1）
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.frame = CGRectMake(0, 0, 150, 150);//设置Frame
    //    bgLayer.position = self.WaterRippleBack.center;//居中显示
    bgLayer.fillColor = UIColor.whiteColor.CGColor;//填充颜色=透明色
    bgLayer.lineWidth = 10.f;//线条大小
    bgLayer.strokeColor = SKThemeColor.dark.CGColor;//线条颜色
    bgLayer.strokeStart = 0.f;//路径开始位置
    bgLayer.strokeEnd = 1.f;//路径结束位置
    bgLayer.path = circle.CGPath;//设置bgLayer的绘制路径为circle的路径
    [self.WaterRippleBack.layer addSublayer:bgLayer];//添加到屏幕上
    
    [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.WaterRippleBack);
        make.size.equalTo(self.WaterRippleBack).multipliedBy(0.5);
    }];
    
    [self.WaterRippleBack bringSubviewToFront:self.WeChatWorkCount];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.WeChatWorkNumber.text = @([SKUserGet(@"WeChatWorkDingdanData") count]).stringValue;
}

- (WaterRippleAndView *)BackView {
    if (!_BackView) {
        _BackView = [[WaterRippleAndView alloc] init];
    }
    return _BackView;
}

- (IBAction)WeChatWorkActions:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {
            WeChatWorkDingdanController *WeChatWorkDingdanController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeChatWorkDingdanController"];
            [self.navigationController pushViewController:WeChatWorkDingdanController animated:YES];
        }
            break;
        case 1: {
            WeChatWorkPassWordController *WeChatWorkPassWordController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeChatWorkPassWordController"];
            [self.navigationController pushViewController:WeChatWorkPassWordController animated:YES];
        }
            break;
        case 2: {
            WeChatWorkShuiyinController *WeChatWorkShuiyinController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeChatWorkShuiyinController"];
            [self.navigationController pushViewController:WeChatWorkShuiyinController animated:YES];
        }
            break;
        case 3: {
            WeChatWorkDATAController *WeChatWorkDATAController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeChatWorkDATAController"];
            [self.navigationController pushViewController:WeChatWorkDATAController animated:YES];
        }
            break;
        case 4: {
            WeChatWorkJietuViewController *WeChatWorkJietuViewController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeChatWorkJietuViewController"];
            [self.navigationController pushViewController:WeChatWorkJietuViewController animated:YES];
        }
            break;
        case 5: {
            WeChatWorkPinjieController *WeChatWorkPinjieController =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeChatWorkPinjieController"];
            [self.navigationController pushViewController:WeChatWorkPinjieController animated:YES];
        }
            break;
        case 6: {
            [SKT shareOrRate:@"1555039198" Shared:NO];
        }
            break;
        case 7: {
            [SKT shareOrRate:@"1555039198" Shared:YES];
        }
            break;
            
        default:
            break;
    }
}


@end

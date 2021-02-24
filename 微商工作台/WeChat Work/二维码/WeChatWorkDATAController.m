//
//  WeChatWorkDATAController.m
//  APPPSWDBOX
//
//  Created by 卫宫巨侠欧尼酱 on 2020/11/20.
//  Copyright © 2020 SK. All rights reserved.
//

#import "WeChatWorkDATAController.h"
#import "WeChatWorkAddCodeController.h"
#import "PhotoBrowser.h"


@interface WeChatWorkDATACell ()<PBViewControllerDataSource, PBViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *APPPWSDBOXImage;
@property (weak, nonatomic) IBOutlet UILabel *APPPWSDBOXCount;
@property (weak, nonatomic) IBOutlet UILabel *APPPWSDBOXName;
@property (weak, nonatomic) IBOutlet UIView *APPPWSDBOXBack;

@end

@implementation WeChatWorkDATACell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)show:(UIButton *)sender {
    PBViewController *pbViewController = [PBViewController new];
    pbViewController.imageViewClass = UIImageView.class;
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    pbViewController.pb_startPage = 1;
    [[SKT currentVC] presentViewController:pbViewController animated:YES completion:nil];
}

#pragma mark - PBViewControllerDataSource

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return 1;
}

- (UIImage *)viewController:(PBViewController *)viewController imageForPageAtIndex:(NSInteger)index {
    return self.APPPWSDBOXImage.image;
}

- (UIView *)thumbViewForPageAtIndex:(NSInteger)index {
    return nil;
}

#pragma mark - PBViewControllerDelegate

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(__kindof UIImage *)presentedImage {
    [[SKT currentNav] dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(PBViewController *)viewController didLongPressedPageAtIndex:(NSInteger)index presentedImage:(__kindof UIImage *)presentedImage {
    NSLog(@"didLongPressedPageAtIndex: %@", @(index));
}

@end


@interface WeChatWorkDATAController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (strong ,nonatomic) NSMutableArray *APPPWSDBOXData;

@property (assign ,nonatomic) NSInteger type;

@end

@implementation WeChatWorkDATAController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"二维码";
    
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button1.frame = CGRectMake(20, SKHeight-SKBottom-20-42, 42, 42);
    [button1 setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    button1.tintColor = SKThemeColor;
    [button1 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button2.frame = CGRectMake(SKWidth-42-20, SKHeight-SKBottom-20-42, 42, 42);
    [button2 setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    button2.tintColor = SKThemeColor;
    [button2 addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    [self APPPWSDBOXSEtData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)add:(id)sender {
    [self add];
}


- (void)add {
    [WeChatWorkAddCodeController push:YES block:^{
        [self APPPWSDBOXSEtData];
    }];
}

- (void)APPPWSDBOXSEtData {
    self.APPPWSDBOXData = [NSMutableArray array];
    [self.APPPWSDBOXData addObjectsFromArray:SKUserGet(@"QRCODEDATA")];
    self.collectionView.backgroundColor = SKThemeColor;
//    NSArray *temp = SKUserGet(@"QRCODEDATA");
//    for (NSArray *arr in temp) {
//        if ([arr[2] integerValue] == self.type) {
//            [self.APPPWSDBOXData addObject:arr];
//        }
//    }
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.APPPWSDBOXData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeChatWorkDATACell *WeChatWorkDATACell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeChatWorkDATACell" forIndexPath:indexPath];
    NSArray *WeChatWorkDATACellArr = self.APPPWSDBOXData[indexPath.row];
    [SKT save:WeChatWorkDATACellArr Key:@"CODESCORD"];
    WeChatWorkDATACell.APPPWSDBOXName.text = [NSString stringWithFormat:@"%@-%@",([@[@"文本",@"名片",@"电话",@"邮箱",@"账号",@"购物",@"位置",@"收藏",@"记录"] objectAtIndex:[WeChatWorkDATACellArr[2] integerValue]]),WeChatWorkDATACellArr[1]];
    [WeChatWorkDATACell.APPPWSDBOXImage imageUrl:WeChatWorkDATACellArr[0] block:nil];

    return WeChatWorkDATACell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SKWidth/3-3, SKWidth/3+25);
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    text = @"空数据";
    font = SKTitleFont(17);
    textColor = [UIColor colorWithHex:@"545454"];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    text = @"数据为空，请点击右上角添加数据";
    font = SKTitleFont(15);
    textColor = [UIColor colorWithHex:@"545454"];
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:SKThemeColor range:[attributedString.string rangeOfString:@"添加数据"]];
    
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIImage imageNamed:@"icon-1"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    text = @"添加数据";
    font = SKTitleFont(15);
    textColor = self.navigationController.navigationBar.barTintColor;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self add];
}

@end

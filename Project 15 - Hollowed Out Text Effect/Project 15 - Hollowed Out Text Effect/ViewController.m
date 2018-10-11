//
//  ViewController.m
//  Project 15 - Hollowed Out Text Effect
//
//  Created by Jamie on 2018/10/10.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+SubstractedText.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    imageView.image = [UIImage imageNamed:@"BackImage"];

    UIView *lightGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-200)];
    lightGrayView.backgroundColor = [UIColor lightGrayColor];
    lightGrayView.alpha = 0.8;

    /*
     * 思路一
     * 想通过UIGraphics绘制一个透明底白字的图片，再将该图片作为灰色背景的UIView的mask的内容。
     * 结果: 失败
     * 失败原因:
     * mask的contents会获取图片不透明部分的轮廓，该不透明轮廓与原本视图或图层相交的部分才会显露出来。
     * mask应该使用不透明底透明字的图片，才能达到预期效果。生成的alpha通道与预期刚好相反，效果背离预期。
     */

    // 从NSString生成图片
//    NSString *textStr = @"10月20日";
//    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setAlignment:NSTextAlignmentCenter];
//    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
//
//    NSDictionary *attributes = @{NSFontAttributeName            : [UIFont systemFontOfSize:30],
//                                 NSForegroundColorAttributeName : [UIColor blackColor],
//                                 NSBackgroundColorAttributeName : [UIColor clearColor],
//                                 NSParagraphStyleAttributeName : paragraphStyle, };
//    UIImage *image1 = [self imageFromString:textStr attributes:attributes size:CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-200)];

    // 从UILabel生成图片
//    UILabel *temptext  = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-200)];
//    temptext.text = @"10日";
//    temptext.textColor = [UIColor whiteColor];
//    temptext.textAlignment = NSTextAlignmentCenter;
//    temptext.font = [UIFont systemFontOfSize:30];
//    UIImage *image1 = [self imageFromView:temptext];

    /*
     * 思路二
     * 先绘制一个透明背景不透明字的图片，再将图片的alpha值进行反向转换，生成不透明背景透明字的图片。再将此图片设为mask的轮廓。
     * 参考资料 https://stackoverflow.com/questions/8721019/drawrect-drawing-transparent-text
     */
    UILabel *knockoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-200)];
    [knockoutLabel setText:@"10月11日"];
    knockoutLabel.textAlignment = NSTextAlignmentCenter;
    [knockoutLabel setFont:[UIFont boldSystemFontOfSize:72.0]];
    [knockoutLabel setNumberOfLines:1];
    [knockoutLabel setBackgroundColor:[UIColor clearColor]];
    [knockoutLabel setTextColor:[UIColor whiteColor]];
    //核心代码 invertAlpha
    UIImage *image1 = [[self imageFromView:knockoutLabel] invertAlpha];


    //生成mask及设置其轮廓
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (__bridge id _Nullable)(image1.CGImage);
    maskLayer.anchorPoint = CGPointZero;
    maskLayer.bounds = CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-200);
    //给灰色的view设置mask
    [lightGrayView.layer setMask:maskLayer];

    [self.view addSubview:imageView];
    [self.view addSubview:lightGrayView];

//    UIImageView *textimageview = [[UIImageView alloc] initWithImage:image1];
//    [self.view addSubview:textimageview];
}


- (UIImage *)imageFromString:(NSString *)string attributes:(NSDictionary *)attributes size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [string drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    else
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


@end

//
//  ViewController.m
//  QR Code
//
//  Created by Jamie on 2018/3/22.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@property (nonatomic,strong) UIImageView *QRView;
@property (nonatomic,strong) UIImageView *logo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSString *url = @"https://github.com/jxa184971";
    self.QRView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    self.QRView.image = [self getQRCodeImageFromString:url];
    self.QRView.clipsToBounds = YES;

    [self.view addSubview:self.QRView];
}

-(UIImage *)getQRCodeImageFromString:(NSString *)url{
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];

    // 2. 给滤镜添加数据
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    // 将UTF-8编码的字符串数据传入inputMessage中，每个滤镜可以设置的参数都不同
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 二维码容错级别选择H，容错级别：L（7%）、M（15%）、Q（25%）、H（30%）
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];

    // 3. 生成二维码
    CIImage *qrImage = [filter outputImage];

    // 4. 给生成的二维码图片增加颜色滤镜
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setDefaults];
    [colorFilter setValue:qrImage forKey:kCIInputImageKey];
    // 设定前景色 135,206,250浅蓝色
    [colorFilter setValue:[CIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:250.0/255.0] forKey:@"inputColor0"];
    // 设定背景色
    [colorFilter setValue:[CIColor whiteColor] forKey:@"inputColor1"];
    CIImage *colorImage = colorFilter.outputImage;

    // 5. 生成的二维码太过模糊，需要优化二维码的显示清晰度
    CGFloat size = 300;
    CGFloat scale = size/colorImage.extent.size.width;
    //通过放大transform增加图片的像素
    UIImage *finalQRImage = [UIImage imageWithCIImage:[colorImage imageByApplyingTransform:CGAffineTransformMakeScale(scale, scale)]];

    // 添加到Container
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    imageView.image = finalQRImage;
    [containerView addSubview:imageView];

    //在二维码中间增加logo或者其他图片，注意遮住面积不要大于二维码可容错范围
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0.35*size, 0.35*size, 0.3*size, 0.3*size)];
    logo.image = [UIImage imageNamed:@"LOGO"];
    [containerView addSubview:logo];

    // 将UIView绘制成UIImage
    UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, containerView.opaque, 0.0);
    [containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    [containerView drawViewHierarchyInRect:containerView.bounds afterScreenUpdates:NO];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

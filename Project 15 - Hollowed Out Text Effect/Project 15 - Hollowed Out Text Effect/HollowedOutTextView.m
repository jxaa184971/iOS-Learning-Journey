//
//  HollowedOutTextView.m
//  Project 15 - Hollowed Out Text Effect
//
//  Created by Jamie on 2018/10/11.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "HollowedOutTextView.h"

@implementation HollowedOutTextView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor]; //需先将背景置为透明
    }
    return self;
}

-(void)setHollowedOutText:(NSString *)hollowedOutText {
    _hollowedOutText = hollowedOutText;

    [self setNeedsDisplay]; //表示需要重绘，系统会自动异步调用 drawRect: 方法
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 前提:需要保证UIView的背景色设置为透明了，否则会出现问题

    //获取CGContext
    CGContextRef context = UIGraphicsGetCurrentContext();

    [[UIColor whiteColor] setFill]; //设置填充颜色
    CGContextAddRect(context, rect); //设置填充形状大小
    CGContextSetAlpha(context, 0.9); //设置填充alpha值
    CGContextFillPath(context); //填充

    if (self.hollowedOutText && self.hollowedOutText.length > 0) {
        [self drawSubtractedText:self.hollowedOutText inRect:rect inContext:context];
    }
}

- (void)drawSubtractedText:(NSString *)text inRect:(CGRect)rect inContext:(CGContextRef)context {
    // 压栈操作，保存一份当前图形上下文，开始绘制时调用
    CGContextSaveGState(context);

    /*
     * 设置混合模式
     * kCGBlendModeDestinationOut 绘制的部分会直接镂空（自己猜测的）
     */
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);

    //设置需要绘制的label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    label.font = [UIFont boldSystemFontOfSize:60];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [label.layer drawInContext:context];

    //出栈操作，恢复一份当前图形上下文，绘制结束时调用
    CGContextRestoreGState(context);
}

@end

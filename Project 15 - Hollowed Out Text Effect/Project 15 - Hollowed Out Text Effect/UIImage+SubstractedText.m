//
//  UIImage+SubstractedText.m
//  Project 15 - Hollowed Out Text Effect
//
//  Created by Jamie on 2018/10/11.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "UIImage+SubstractedText.h"

@implementation UIImage (SubstractedText)

/*
 get the image to invert its alpha channel
 */
- (UIImage *)invertAlpha
{
    // scale is needed for retina devices
    CGFloat scale = [self scale];
    CGSize size = self.size;
    int width = size.width * scale;
    int height = size.height * scale;

    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();

    unsigned char *memoryPool = (unsigned char *)calloc(width*height*4, 1);

    CGContextRef context = CGBitmapContextCreate(memoryPool, width, height, 8, width * 4, colourSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);

    CGColorSpaceRelease(colourSpace);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);

    for(int y = 0; y < height; y++)
    {
        unsigned char *linePointer = &memoryPool[y * width * 4];
        for(int x = 0; x < width; x++)
        {
            linePointer[3] = 255-linePointer[3];
            linePointer += 4;
        }
    }

    // get a CG image from the context, wrap that into a
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage scale:scale orientation:UIImageOrientationUp];

    // clean up
    CGImageRelease(cgImage);
    CGContextRelease(context);
    free(memoryPool);

    // and return
    return returnImage;
}

@end

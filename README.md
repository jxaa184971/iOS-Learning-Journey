# iOS Learning Journey
- Personal iOS Learning Journey

------

[TOC]

------
# 1. UIImage
## 1.1 UIImage Resize
在开始生成新的图片之前, 需要有画图的环境. 使用以下方法开始生成画图环境.

> UIGraphicsBeginImageContextWithOptions(_ size: CGSize, _ opaque: Bool, _ scale: CGFloat) 

opaque: true为整个context不透明, false为可以部分透明

得到画图环境后, UIImage的drawInRect(_ rect: CGRect)方法生成新的图像.

使用UIGraphicsGetImageFromCurrentImageContext()得到重新改变大小的图片.

关闭画图环境.

``` Swift
static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        // 用新的图片宽度除以原来图片的宽度得到其比例
        let scale = newWidth / image.size.width
        // 用得到的比例计算新的图片高度
        let newHeight = image.size.height * scale

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
}
```




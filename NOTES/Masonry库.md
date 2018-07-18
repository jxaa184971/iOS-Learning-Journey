# Masonry库

Masonry 源码：https://github.com/Masonry/Masonry

Masonry是一个轻量级的布局框架 拥有自己的描述语法 采用更优雅的链式语法封装自动布局 简洁明了 并具有高可读性 而且同时支持 iOS 和 Max OS X。

### 导入库
```objective-c
pod 'Masonry'
```

### 导入头文件
```objective-c
#import "Masonry.h"
```

### MAS的属性和NSLayout属性的对比
|MASViewAttribute|NSLayoutAttribute|
| ------ | ------ |
|view.mas_left|NSLayoutAttributeLeft|
|view.mas_right|NSLayoutAttributeRight|
|view.mas_top|NSLayoutAttributeTop| 
|view.mas_bottom|NSLayoutAttributeBottom|
|view.mas_leading|NSLayoutAttributeLeading|
|view.mas_trailing|NSLayoutAttributeTrailing|
|view.mas_width|NSLayoutAttributeWidth|
|view.mas_height|NSLayoutAttributeHeight|
|view.mas_centerX|NSLayoutAttributeCenterX|
|view.mas_centerY|NSLayoutAttributeCenterY|
|view.mas_baseline|NSLayoutAttributeBaseline|

### edges属性
```objective-c
// make top, left, bottom, right equal view2
make.edges.equalTo(view2);

// make top = superview.top + 5, left = superview.left + 10,
// bottom = superview.bottom - 15, right = superview.right - 20
make.edges.equalTo(superview).insets(UIEdgeInsetsMake(5, 10, 15, 20))
```
### size属性
```objective-c
// make width and height greater than or equal to titleLabel
make.size.greaterThanOrEqualTo(titleLabel)

// make width = superview.width + 100, height = superview.height - 50
make.size.equalTo(superview).sizeOffset(CGSizeMake(100, -50))
```
### center属性
```objective-c
// make centerX and centerY = button1
make.center.equalTo(button1)

// make centerX = superview.centerX - 5, centerY = superview.centerY + 10
make.center.equalTo(superview).centerOffset(CGPointMake(-5, 10))
```

### 调用方法

* mas_makeConstraints 建立约束，如果已经有约束则不再调用

* mas_remakeConstraints 重新建立约束，删除原有约束新建新的约束

* mas_equalTo 是一个MACRO，除了NSNumber支持的那些数值类型之外 就只支持CGPoint CGSize UIEdgeInsets。多用来跟某一个数值进行比较

* equalTo 用来跟某一个View进行比较

### 例子
```objective-c
[self.bannerView makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.top).offset(SafeAreaTopHeight);
    make.right.equalTo(self.right);
    make.left.equalTo(self.left);
    make.bottom.equalTo(self.bottom);
}];

[self.ADIcon remakeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.bannerView.bottom).offset(-10*PLUS_SCALE);
    make.right.equalTo(self.bannerView.right).offset(-10*PLUS_SCALE);
    make.width.height.mas_equalTo(30*PLUS_SCALE);
}];
```

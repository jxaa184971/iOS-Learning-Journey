# 单指点击旋转、拖动以及缩放UIview
实际开发中如果需要使用到编辑图片、编辑文本框之类的需求，例如拍照之后增加一些图片元素。可能会涉及到对一个view进行旋转、拖动以及缩放。下面记录了这些需求实现的方法。

### 旋转
在自定义的UIView文件中，重写`-touchesMoved:withEvent:`方法。获取当前手指坐标和上一个手指坐标，通过坐标轴计算出移动的角度，再通过`CGAffineTransformRoate()`方法来进行旋转。

具体代码实现如下:

```objective-c
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSUInteger toucheNum = [[event allTouches] count];//有几个手指触摸屏幕
    if ( toucheNum > 1 ) {
        return;//多个手指不执行操作
    }
    
    //旋转
    CGPoint center = CGPointMake(CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds]));
    CGPoint currentPoint = [touch locationInView:self];//当前手指的坐标
    CGPoint previousPoint = [touch previousLocationInView:self];//上一个坐标

    /**
     求得每次手指移动变化的角度
     atan2f 是求反正切函数 参考:http://blog.csdn.net/chinabinlang/article/details/6802686
     */
    CGFloat angle = atan2f(currentPoint.y - center.y, currentPoint.x - center.x) - atan2f(previousPoint.y - center.y, previousPoint.x - center.x);

    //修改视图角度
    self.transform = CGAffineTransformRotate(self.transform, angle);
}
```

### 移动
与旋转同理，获取当前手指坐标和上一个手指坐标，计算出两个坐标的x轴上和y轴上的偏移量，通过`CGAffineTransformTranslate()`方法修改view的位置。
```objective-c
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSUInteger toucheNum = [[event allTouches] count];//有几个手指触摸屏幕
    if ( toucheNum > 1 ) {
        return;//多个手指不执行操作
    }
    
    CGPoint currentPoint = [touch locationInView:self]; //当前手指的坐标
    CGPoint previousPoint = [touch previousLocationInView:self]; //上一个坐标

    //计算偏移量
    CGFloat offsetX = currentPoint.x - previousPoint.x;
    CGFloat offsetY = currentPoint.y - previousPoint.y;

    //修改视图位置
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}
```

### 缩放
与移动类似，先计算当前手指位置和上一个手指位置在x轴y轴上的偏移量，通过偏移量来修改view的bounds的宽高。

#### PS：注意，一定要修改bounds的宽高而不是修改frame。旋转过tranform的view，如果修改frame的宽高，会发生不可预计的情况。

```objective-c
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSUInteger toucheNum = [[event allTouches] count];//有几个手指触摸屏幕
    if ( toucheNum > 1 ) {
        return;//多个手指不执行操作
    }
    
    CGPoint currentPoint = [touch locationInView:self]; //当前手指的坐标
    CGPoint previousPoint = [touch previousLocationInView:self]; //上一个坐标

    //计算偏移量
    CGFloat offsetX = currentPoint.x - previousPoint.x;
    CGFloat offsetY = currentPoint.y - previousPoint.y;
    CGFloat newBoundWidth = self.bounds.size.width + offsetX;
    CGFloat newBoundHeight = self.bounds.size.height + offsetY;

    //修改视图的bounds
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, newBoundWidth, newBoundHeight);
}
```

# 对drawRect的理解
## 写在前面
* 默认情况下，该方法在视图加载过程中不做任何人处理。当子类使用`Core Graphics`和`UIKit`绘制视图内容时就需要在该方法中添加绘制的代码。
* 该方法定义在`UIView(UIViewRendering)`分类里面，望文生义，该方法完成视图的绘制。

## drawRect作用
* `Only override drawRect: if you perform custom drawing.`
* 重绘作用：重写该方法以实现自定义的绘制内容

## drawRect调用时机
* 视图第一次显示的时候会调用。这个是由系统自动调用的，主要是在`UIViewController`中`loadView和viewDidLoad`方法调用之后；
* 如果在`UIView`初始化时没有设置`rect`大小，将直接导致`drawRect:`不被自动调用；
* 该方法在调用`sizeThatFits`后被调用，所以可以先调用`sizeToFit`计算出size,然后系统自动调用`drawRect:`方法；
* 通过设置`contentMode`属性值为`UIViewContentModeRedraw`,那么将在每次设置或更改`frame`的时候自动调用`drawRect:`;
* 直接调用`setNeedsDisplay`，或者`setNeedsDisplayInRect:`触发`drawRect:`，但是有个前提条件是`rect`不能为0;

## drawRect重绘方法定义
* `- (void)drawRect:(CGRect)rect` 重写此方法，执行重绘任务;
* `- (void)setNeedsDisplay` 标记为需要重绘，异步调用`drawRect:`，但是绘制视图的动作需要等到下一个绘制周期执行，并非调用该方法立即执行;
* `- (void)setNeedsDisplayInRect:(CGRect)rect` 标记为需要局部重绘，具体调用时机同上;

## drawRect使用注意事项
* 如果子类直接继承自`UIView`,则在`drawRect:`方法中不需要调用`super`方法。若子类继承自其他View类则需要调用`super`方法以实现重绘。
* 若使用`UIView`绘图，只能在`drawRect:`方法中获取绘制视图的`contextRef`。在其他方法中获取的`contextRef`都是不生效的；
* `drawRect:`方法不能手动调用，需要调用实例方法`setNeedsDisplay`或者`setNeedsDisplayInRect`,让系统自动调用该方法；
* 若使用`CALayer`绘图，只能在`drawInContext:`绘制，或者在`delegate`方法中进行绘制，然后调用`setNeedDisplay`方法实现最终的绘制；
* `UIImageView`继承自`UIView`,但是`UIImageView`能不重写`drawRect:`方法用于实现自定义绘图。具体原因如下图苹果官方文档所示：
![image](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/PIC/1713024374336bff0e5c456.png)

# UIVisualEffectView - 磨砂效果

### 简介
创建一个UIVisualEffectView视图对象，这个对象提供了一种简单的方式来实现复杂的视觉效果，这个可以把这个对象看作是效果的一个容器。
1. UIVisualEffectView实际的效果会影响到该视图对象底下的内容。
2. UIVisualEffectView实际的效果会影响添加到该视图对象的contentView中的内容。

获得视觉效果有两种方式：
1. 将UIVisualEffectView视图作为一个遮罩视图。透过遮罩视图，看到后面的视图就是模糊的。
2. 将需要模糊处理的内容视图添加到UIVisualEffectView的contentView中，但是UIVisualEffectView视图后面的内容还是会受到影响，产生模糊效果。

#### 注意点：
1. 不应该直接添加子视图到UIVisualEffectView视图中，而是应该添加到UIVisualEffectView对象的contentView中。
2. 尽量避免将UIVisualEffectView对象的alpha值设置为小于1.0的值，因为创建半透明的视图会导致系统在离屏渲染时去对UIVisualEffectView对象及所有的相关的子视图做混合操作。可能会导致许多效果显示不正确或者根本不显示。
3. 对UIVisualEffectView的父视图添加mask会导致效果失效，并且会抛出异常。

### UIVisualEffect
UIVisualEffect是一个集成自NSObject的基类。两个子类：
* UIBlurEffect - 磨砂效果
* UIVibrancyEffect - 生动效果

#### 注意点
* 一个UIBlurEffect对象用于将blur(毛玻璃)效果应用于UIVisualEffectView视图下面的内容。如上面的示例所示。不过，这个对象的效果并不影响UIVisualEffectView对象的contentView中的内容。
* UIVibrancyEffect主要用于放大和调整UIVisualEffectView视图下面的内容的颜色，同时让UIVisualEffectView的contentView中的内容看起来更加生动（我完全看不出来什么明显的变化）。这种效果仅仅对与添加到contentView中的内容有效果。因为这种生动效果依赖于颜色，添加到contentView中的subViews需要实现tintColorDidChange方法，并及时更新。如果是UIImageView，必须设置其渲染方式为UIImageRenderingModeAlwaysTemplate。

### 代码样例
```objective-c
- (void)addEffectView {
    // 磨砂效果
    self.effectView1 = [[UIVisualEffectView alloc] initWithEffect: [UIBlurEffect effectWithStyle: UIBlurEffectStyleExtraLight]];
    self.effectView1.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100);
    [self.view bringSubviewToFront:self.effectView1];
    [self.view addSubview:self.effectView1];


    // 生动效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVibrancyEffect *effect2 = [UIVibrancyEffect effectForBlurEffect:effect];
    self.effectView2 = [[UIVisualEffectView alloc] initWithEffect:effect2];
    self.effectView2.frame = CGRectMake(0, 300, [[UIScreen mainScreen] bounds].size.width, 100);

    // 这种效果仅仅对与添加到contentView中的内容有效果, 在这里添加一个带有红色背景的UIView
    UIView *redView = [[UIView alloc]initWithFrame:self.effectView2.bounds];
    redView.backgroundColor = [UIColor redColor];
    redView.alpha = 0.8;
    [self.effectView2.contentView addSubview:redView];

    [self.view bringSubviewToFront:self.effectView2];
    [self.view addSubview:self.effectView2];
}
```

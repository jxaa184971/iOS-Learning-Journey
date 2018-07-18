# UIVisualEffectView - 高斯模糊效果

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
* UIBlurEffect (模糊效果)
* UIVibrancyEffect (在模糊效果上实现特殊效果)

#### 注意点
* 一个UIBlurEffect对象用于将blur(毛玻璃)效果应用于UIVisualEffectView视图下面的内容。如上面的示例所示。不过，这个对象的效果并不影响UIVisualEffectView对象的contentView中的内容。
* UIVibrancyEffect主要用于放大和调整UIVisualEffectView视图下面的内容的颜色，同时让UIVisualEffectView的contentView中的内容看起来更加生动。（可以理解为在毛玻璃上滴了一滴水，用水在毛玻璃上进行写字。写字的效果就是 UIVibrancyEffect 效果的简单使用）

### 代码样例
```objective-c
- (void)viewDidLoad {
    self.effectView = [[UIVisualEffectView alloc] initWithEffect: [UIBlurEffect effectWithStyle: UIBlurEffectStyleExtraLight]];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleExtraLight];
    self.effectView.effect = effect;
    self.effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, iphoneStateHeight);
    self.effectView.alpha = 0.5;
    [self.view bringSubviewToFront:self.effectView];
    [self.view addSubview:self.effectView];
}
```

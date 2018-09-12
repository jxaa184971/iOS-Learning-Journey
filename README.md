# iOS Learning Journey
- Personal iOS Learning Journey

## 目录(Table of Contents)
- [iOS Learning Notes](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES.md)
    - [Mansory库 - 好用的第三方AutoLayout库](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/Masonry%E5%BA%93.md)
    - [UIImagePickerController - 相机照片选择器](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/UIImagePickerController%E7%9B%B8%E6%9C%BA%E7%85%A7%E7%89%87%E9%80%89%E6%8B%A9%E5%99%A8.md)
    - [iOS NSNotification - 消息通知](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/iOS%20NSNotification%20-%20%E6%B6%88%E6%81%AF%E9%80%9A%E7%9F%A5.md)
    - [Grand Central Dispatch - iOS多线程GCD简介](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/iOS%E5%A4%9A%E7%BA%BF%E7%A8%8BGCD%E7%AE%80%E4%BB%8B.md#ios%E5%A4%9A%E7%BA%BF%E7%A8%8Bgcd%E7%AE%80%E4%BB%8B)
    - [UIVisualEffectView - 磨砂效果](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/UIVisualEffectView%20-%20%E7%A3%A8%E7%A0%82%E6%95%88%E6%9E%9C.md)
    - [AVAudioSession - 音频控制](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/AVAudioSession%20%E9%9F%B3%E9%A2%91%E6%8E%A7%E5%88%B6.md)
    - [获取网络状态及网络类型](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/%E8%8E%B7%E5%8F%96%E7%BD%91%E7%BB%9C%E7%8A%B6%E6%80%81%E5%8F%8A%E7%BD%91%E7%BB%9C%E7%B1%BB%E5%9E%8B.md)
    - [weak type self](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/weak%20type%20self.md)
    - [CoreLocation - 获取GPS所在的城市或省份](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/%E8%8E%B7%E5%8F%96GPS%E6%89%80%E5%9C%A8%E7%9A%84%E5%9F%8E%E5%B8%82%E6%88%96%E7%9C%81%E4%BB%BD.md)
    - [通过View寻找其所在的ViewController](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/%E9%80%9A%E8%BF%87View%E5%AF%BB%E6%89%BE%E5%85%B6%E6%89%80%E5%9C%A8%E7%9A%84ViewController.md)
    - [runtime将Dictionary转为指定Model的对象](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/runtime%E5%B0%86Dictionary%E8%BD%AC%E4%B8%BA%E6%8C%87%E5%AE%9AModel%E7%9A%84%E5%AF%B9%E8%B1%A1.md)
    - [UIWebView以及WKWebView的UA设置](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/UIWebView%E4%BB%A5%E5%8F%8AWKWebView%E7%9A%84UA%E8%AE%BE%E7%BD%AE.md)
    - [从UIWebView中获取JS点击事件](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/%E4%BB%8EUIWebView%E4%B8%AD%E8%8E%B7%E5%8F%96JS%E7%82%B9%E5%87%BB%E4%BA%8B%E4%BB%B6.md)
    - [WKWebView](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/WKWebView.md)
    - [从WKWebView中获取JS点击事件](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/%E4%BB%8EWKWebView%E4%B8%AD%E8%8E%B7%E5%8F%96JS%E7%82%B9%E5%87%BB%E4%BA%8B%E4%BB%B6.md)
- [iOS Learning Demos](#ios-learning-journey)
    - [Project 01 - UIImage Resize](#project-01---uiimage-resize)
    - [Project 02 - HTTP Request & JSON](#project-02---http-request-and-json)
    - [Project 03 - Splash Launching](#project-03---splash-launching)    
    - [Project 04 - Simple Animation](#project-04---simple-animation)
    - [Project 05 - Log In Animation](#project-05---log-in-animation)
    - [Project 06 - Video Background](#project-06---video-background)
    - [Project 07 - Custom Segue](#project-07---custom-segue)
    - [Project 08 - Pull To Refresh](#project-08---pull-to-refresh)
    - [Project 09 - Banner 头条轮播效果](#project-09---banner)
    - [Project 10 - Window Effect 橱窗效果](#project-10---window-effect)
    - [Project 11 - QR Code 二维码生成](#project-11---qr-code)
    - [Project 12 - UILocalizedIndexedCollation 分类排序](#project-12---uilocalizedindexedcollation)
    - [Project 13 - AnimatedTransitioning 转场动画](#project-13---animatedtransitioning)
    - [Project 14 - UIVisualEffectView 磨砂效果](#project-14---uivisualeffectview)

### Project 01 - UIImage Resize
在使用图片的时候, 有时候图片的原本像素太大, 导致显示的时候图片显示异常. 例如使用地图自定义大头针的时候, 如果图片像素过大, 大头针会铺满整个屏幕, 直接缩小修改图片的大小又会导致大头针图像变得模糊. 这时候就需要更改UIImage到所需要的像素.

![project01](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2001%20-%20UIImage%20Resize/Project01.gif)

以下是基本实现方法:

在开始生成新的图片之前, 需要有图片生成的环境. 使用`UIGraphicsBeginImageContextWithOptions(_ size: CGSize, _ opaque: Bool, _ scale: CGFloat)`方法生成环境. opaque: true为整个context不透明, false为可以部分透明.

得到画图环境后, UIImage的`drawInRect(_ rect: CGRect)`方法生成新的图像.

使用`UIGraphicsGetImageFromCurrentImageContext()`得到重新改变大小的图片.

关闭画图环境`UIGraphicsEndImageContext()`.

##### 具体实现代码:

``` Swift
func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
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

<br></br>

### Project 02 - HTTP Request and JSON
发送HTTP同步请求及JSON格式的数据处理
 
![project02](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2002%20-%20HTTP%20Request%20%26%20JSON/Project02.gif)

实现方法:

需要有一个NSURL对象来封装需要访问的url地址 `NSURL(string: "http://httpbin.org/get")`
 
通过该NSURL对象来生成NSRequest对象 `NSURLRequest(URL: url!)`
 
需要NSResponse对象来储存访问结果 
 
通过NSURLConnection来发送HTTP请求 `try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)`

最后通过对获取的NSData进行JSON解析 `try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)`

PS: 由于安全问题, 在新版本的iOS系统中禁止使用明码HTTP请求, 所以在使用前需要在plist里面添加以下字段

```
<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
```
##### 具体实现代码:

``` swift
func sendRequest() -> Array<String>?
    {
        let url = NSURL(string: "http://httpbin.org/get")
        let request: NSURLRequest = NSURLRequest(URL: url!)
        let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        
        do
        {
            let data:NSData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
            let results = self.parseJSONToString(data)
            if results != nil
            {
                return results!
            }
        }
        catch
        {
            print("Error when sending request")
        }
        return nil
    }
    
    func parseJSONToString(data:NSData) -> Array<String>?
    {
        var results = Array<String>()
        
        do {
            let entry = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let headers = entry.valueForKey("headers") as! NSDictionary
            let host = headers.valueForKey("Host") as! String
            let acceptLanguage = headers.valueForKey("Accept-Language") as! String
            
            let origin = entry.valueForKey("origin") as! String
            let url = entry.valueForKey("url") as! String
            
            results.append(host)
            results.append(acceptLanguage)
            results.append(origin)
            results.append(url)
            
            return results
        }
        catch
        {
            print("error serializing JSON: \(error)")
            return nil
        }
    }
```
<br></br>

### Project 03 - Splash Launching
模仿Twitter的Lauching动画

![project03](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2003%20-%20Splash%20Lauching/Project03.gif)

实现方法:
通过改变CALayer mask属性的边界bound来实现动画效果. mask就是定义该Layer显示的部分.在这里显示的部分最初与Twitter Logo相吻合, 然后略微缩小, 最后放大至超过屏幕大小.

具体动画实现代码如下:
```swift
// keyPath用来定义动画所改变的CALayer的属性, 在这里改变的为mask的bounds属性
let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
keyFrameAnimation.delegate = self
keyFrameAnimation.duration = 1
keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        
// timing functions用来设置每两帧之间的动画效果. 例如有n帧, 就需要有n-1个timeFunctions
keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
 
let initalBounds = NSValue(CGRect: mask!.bounds)
let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 3200, height: 3200))
        
keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
// keyTimes用来定义每一帧的时间点
keyFrameAnimation.keyTimes = [0, 0.33, 1]
        
// 添加动画并播放
self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds")
```
动画结束后需要调用delegate方法`animationDidStop(anim: CAAnimation, finished flag: Bool)`来取消mask

```swift
override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    // 当动画结束时, 将该界面的mask设置为nil
    self.controller?.view.layer.mask = nil
}
```

<br></br>

### Project 04 - Simple Animation
本项目介绍了利用`UIView.animateWithDuration()`方法来实现一些简单的动画, 包括位置的改变, 透明度的改变, 大小的改变, 颜色的改变已经旋转. 效果图如下:

##### 位置
![project04](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2004%20-%20Simple%20Animation/Position.gif)
##### 透明度
![project04](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2004%20-%20Simple%20Animation/Opacity.gif)
##### 大小
![project04](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2004%20-%20Simple%20Animation/Scale.gif)
##### 颜色
![project04](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2004%20-%20Simple%20Animation/Color.gif)
##### 旋转
![project04](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2004%20-%20Simple%20Animation/Rotation.gif)

<br></br>

### Project 05 - Log In Animation
此项目为实现一些登录界面的动画效果, 让用户交互体验提高。

![project05](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2005%20-%20Log%20In%20Animation/Project%2005.gif)

<br></br>

### Project 06 - Video Background
此项目模仿Spotify公司实现了登录界面的视频背景.

![project06](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2006%20-%20VideoBackground/Project%2006.gif)

<br></br>

### Project 07 - Custom Segue
此项目实现了自定义Segue及Unwind Segue. 
包括UIStoryboardSegue的实现, 页面的自定义动画跳转, 手势的添加等.

![project07](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2007%20-%20Custom%20Segue/Project%2007.gif)

<br></br>

### Project 08 - Pull To Refresh
此项目实现了TableView的下拉刷新效果

![project08](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2008%20-%20Pull%20To%20Refresh/Project%2008.gif)

<br></br>

### Project 09 - Banner
此项目实现了轮播头条的效果.

利用UICollectionView, 采用N+2的方式实现无限翻转的轮播效果. 了解了UICollectionView, UIPageControl的使用方法.

#### 实现原理
如果指定轮播的图片(或View)为5张, 那么在UICollectionView的前面增加最后一张的图片(或View), 最后增加第一张图片(或View). 最终UICollectionView的排列为: 5 1 2 3 4 5 1. 每次滑到首位(第一个5)时, 通过代码移动到相同样式的倒数第二的位置(倒数第二个5); 滑到末位(最后一个1)时, 通过代码移动到相应样式的第二个位置(第一个1). 用这样的方法来达到无限循环的效果.

![project09](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2009%20-%20Banner/Project%2009.gif)

<br></br>

### Project 10 - Window Effect
此项目实现了UITableView中的橱窗显示图片的效果. 

![project10](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2010%20-%20Window%20Effect/Project%2010.gif)

#### 实现原理
首先需要选择一张需要实现橱窗效果的图片, 其高度需要高于cell本身的高度, 将其放入cell中靠顶部显示. 每次用户滑动tablview时, 调动cell中自定义的方法. 该方法计算UIImageView中心点到window中心的距离(offset), 再通过修改UIImageView的transform将图片偏移-offset, 通过此方式使图片始终固定在window的中心. 再利用cell的clipsToBounds属性不显示超出cell的图片，从而最终达到橱窗的效果.

#### 核心代码
```swift
func resetImagePosition(){
    // 获取图片在window中的bounds
    let cellBoundsInWindow = self.convert(self.picView.bounds, to: self.window)

    if (cellBoundsInWindow.origin.y <= ((self.window?.bounds.height)!-self.picView.bounds.height)/2) {
        //当cell滑到图片顶端的时候，图片跟着cell一起上滑
        return
    }

    // 获取图片在window中bounds的Y轴中心点
    let cellCenterY = cellBoundsInWindow.midY
    // 获取window的Y轴中心点
    let windowCenterY = self.window?.center.y;

    // 获取Y轴图片中心点和window中心点的offset
    let offsetY = cellCenterY - windowCenterY!;
    // 每次tableview滑动时，都需要重新设置UIImageView的transform，使其显示在window的中心
    let transform = CGAffineTransform(translationX: 0, y: -offsetY)
    self.picView.transform = transform;
}
```

<br></br>

### Project 11 - QR Code
此项目实现了将URL字符串转换成二维码的功能。项目中还附带了修改二维码颜色的代码，以及将UIView截屏成UIImage的代码。

![project11](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2011%20-%20QR%20Code/Project%2011.png)

#### 核心代码
```objective-c
NSString *url = @"https://github.com/jxa184971";
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
```
将UIView绘制成UIImage
```objective-c
/* 将UIView绘制成UIImage */
// 初始化绘图环境 opaque参数用来表示生成的图片是否不透明
UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, containerView.opaque, 0.0);
// 将对应的UIView的layer渲染在绘图环境中
[containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
// 将UIView中所有的view hierarchy绘制在环境中
[containerView drawViewHierarchyInRect:containerView.bounds afterScreenUpdates:NO];
// 获取绘制好的图片
UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
// 结束绘图环境
UIGraphicsEndImageContext();
```

<br></br>

### Project 12 - UILocalizedIndexedCollation
此项目实现了利用UILocalizedIndexedCollation来对姓名进行排列，以达到原生通讯录的效果。

![project12](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2012%20-%20UILocalizedIndexedCollation/Project%2012.png)

#### 实现原理
首先通过`[self.localizedCollection sectionForObject:person collationStringSelector:@selector(name)]`方法对每一个person对象对name属性进行分类，根据首字母来进行分类. 比如"林丹", 首字母是L, 在A~Z中排第11(第一位是0), sectionNumber就为11. 

然后再通过`[self.localizedCollection sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)]`对每个字母所代表的section根据name属性对Array中每个person进行排序. 通过此方法，就能把所有的person对象进行分组排序。

#### 核心代码
```objective-c
//将每个人按name分到某个index下
for (Person *temp in tempPersonArray) {
    //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
    NSInteger sectionNumber = [self.localizedCollection sectionForObject:temp collationStringSelector:@selector(name)];
    NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
    [sectionNames addObject:temp];
}

//对每个section中的数组按照name属性排序
for (int index = 0; index < sectionTitlesCount; index++) {
    NSMutableArray *personArrayForSection = newSectionsArray[index];
    NSArray *sortedPersonArrayForSection = [self.localizedCollection sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)];
    newSectionsArray[index] = sortedPersonArrayForSection;
}
```

<br></br>

### Project 13 - AnimatedTransitioning
此项目实现了UINavigationController下页面跳转的自定义转场动画效果。

![project13](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2013%20-%20AnimatedTransitioning/Project%2013.gif)

#### 实现原理
首先需要定义一个NSObject实现UIViewControllerAnimatedTransitioning代理
```objective-c 
@interface TransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
```

</br>
然后在此类中实现两个代理方法：

设置转场动画的时间
```objective-c 
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext；
```
获取到转场动画的context，从中获取到转场前后的viewController用来实现具体的动画效果
```objective-c 
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
```


完成转场动画对象的实现后，需要对转场的VC进行实现。首先对需要实现转场动画的VC实现UINavigationControllerDelegate代理，并将VC所在UINavigationController的delegate设为自己。 
```objective-c 
@interface ViewController ()<UINavigationControllerDelegate> 
```

并且实现以下的方法，根据条件返回刚才我们定义好转场动画对象，即可实现转场动画效果。
```objective-c
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
```

#### 核心代码
```objective-c
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //获取跳转前后的view
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //由于场景转换环境会自动添加fromVC到contrainer中，但是不会自动添加toVC，如果需要对toVC做动画特效需要自己手动添加。
    [transitionContext.containerView addSubview:toVC.view];

    //初始化toVC的alpha值为0
    toVC.view.alpha = 0;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
        fromVC.view.alpha = 0;
    }completion:^(BOOL finished) {
        fromVC.view.alpha = 1;
        [transitionContext completeTransition:YES];
    }];
}
```

```objective-c
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    //根据情况不同，可以将跳转的方式为push还是pop，fromVC和toVC是什么来作为判断条件。
    if ([fromVC isKindOfClass:[ViewController class]] && operation == UINavigationControllerOperationPush) {
        TransitionAnimation *animation = [[TransitionAnimation alloc] init];
        return animation;
    }else {
        //返回nil 会显示默认动画
        return nil;
    }
}
```

<br></br>

### Project 14 - UIVisualEffectView
此项目实现了磨砂效果。了解了如何UIVisualEffectView来实现磨砂效果及生动效果。

相关内容笔记如下：[UIVisualEffectView - 磨砂效果笔记](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/NOTES/UIVisualEffectView%20-%20%E7%A3%A8%E7%A0%82%E6%95%88%E6%9E%9C.md)

![project14](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2014%20-%20UIVisualEffectView/Project%2014.gif)

#### 核心代码
```objective-c
- (void)addEffectView {
    // 磨砂效果
    self.effectView1 = [[UIVisualEffectView alloc] initWithEffect: [UIBlurEffect effectWithStyle: UIBlurEffectStyleExtraLight]];
    self.effectView1.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100);
    [self.view addSubview:self.effectView1];
    [self.view bringSubviewToFront:self.effectView1];
}
```

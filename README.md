# iOS Learning Journey
- Personal iOS Learning Journey

## 目录(Table of Contents)
- [iOS Learning Journey](#ios-learning-journey)
    - [Project 01 - UIImage Resize](#project-01---uiimage-resize)
    - [Project 02 - HTTP Request & JSON](#project-02---http-request-and-json)
    - [Project 03 - Splash Launching](#project-03---splash-launching)    
    - [Project 04 - Simple Animation](#project-04---simple-animation)
    - [Project 05 - Log In Animation](#project-05---log-in-animation)
    - [Project 06 - Video Background](#project-06---video-background)
    - [Project 07 - Custom Segue](#project-07---custom-segue)
    - [Project 08 - Pull To Refresh](#project-08---pull-to-refresh)
    - [Project 09 - Banner](#project-09---banner)
    - [Project 10 - Window Effect](#project-10---window-effect)
    - [Project 11 - QR Code](#project-11---qr-code)
    - [Project 12 - UILocalizedIndexedCollation](#project-12---uilocalizedindexedcollation)
    - [Project 13 - AnimatedTransitioning](#project-13---animatedtransitioning)
</br> </br>

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

</br></br>

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
</br></br>

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


### Project 05 - Log In Animation
此项目为实现一些登录界面的动画效果, 让用户交互体验提高。

![project05](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2005%20-%20Log%20In%20Animation/Project%2005.gif)


### Project 06 - Video Background
此项目模仿Spotify公司实现了登录界面的视频背景.

![project06](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2006%20-%20VideoBackground/Project%2006.gif)

### Project 07 - Custom Segue
此项目实现了自定义Segue及Unwind Segue. 
包括UIStoryboardSegue的实现, 页面的自定义动画跳转, 手势的添加等.

![project07](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2007%20-%20Custom%20Segue/Project%2007.gif)

### Project 08 - Pull To Refresh
此项目实现了TableView的下拉刷新效果

![project08](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2008%20-%20Pull%20To%20Refresh/Project%2008.gif)

### Project 09 - Banner
此项目实现了轮播头条的效果.

利用UICollectionView, 采用N+2的方式实现无限翻转的轮播效果. 了解了UICollectionView, UIPageControl的使用方法.

#### 实现原理
如果指定轮播的图片(或View)为5张, 那么在UICollectionView的前面增加最后一张的图片(或View), 最后增加第一张图片(或View). 最终UICollectionView的排列为: 5 1 2 3 4 5 1. 每次滑到首位(第一个5)时, 通过代码移动到相同样式的倒数第二的位置(倒数第二个5); 滑到末位(最后一个1)时, 通过代码移动到相应样式的第二个位置(第一个1). 用这样的方法来达到无限循环的效果.

![project09](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2009%20-%20Banner/Project%2009.gif)

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

### Project 11 - QR Code

### Project 12 - UILocalizedIndexedCollation

### Project 13 - AnimatedTransitioning

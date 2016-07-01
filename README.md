# iOS Learning Journey
- Personal iOS Learning Journey

##目录(Table of Contents)
- [iOS Learning Journey](#ios-learning-journey)
    - [Project 01 - UIImage Resize](#project-01---uiimage-resize)
    - [Project 02 - HTTP Request & JSON](#project-02---http-request-and-json)
    - [Project 03 - Splash Launching](#project-03---splash-launching)    

<br\><br\>
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

<br\><br\>

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
<br\><br\>

### Project 03 - Splash Launching
模仿Twitter的Lauching动画

![project03](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2003%20-%20Splash%20Lauching/Project03.gif)

实现方法:
通过改变CALayer mask属性的边界bound来实现动画效果. mask就是定义该Layer显示的部分.在这里显示的部分最初与Twitter Logo相吻合, 然后略微缩小, 最后放大至超过屏幕大小.

具体动画实现代码如下:
```swift
let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        
        // timing functions用来设置每两个值之间的动画效果. 例如有n个values, 就需要有n-1个timeFunctions
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

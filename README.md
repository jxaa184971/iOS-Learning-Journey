# iOS Learning Journey
- Personal iOS Learning Journey

#目录
- [iOS Learning Journey](#ios-learning-journey)
    - [Project 01 - UIImage Resize](#project-01---uiimage-resize)
    - [Project 02 - HTTP Request & JSON](#project-02---http-request-and-json)
    
<br\><br\>
### Project 01 - UIImage Resize
在使用图片的时候, 有时候图片的原本像素太大, 导致显示的时候图片显示异常. 例如使用地图自定义大头针的时候, 如果图片像素过大, 大头针会铺满整个屏幕, 直接缩小修改图片的大小又会导致大头针图像变得模糊. 这时候就需要更改UIImage到所需要的像素.

![project01](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2001%20-%20UIImage%20Resize/Project01.gif)

以下是基本实现方法:

在开始生成新的图片之前, 需要有图片生成的环境. 使用`UIGraphicsBeginImageContextWithOptions(_ size: CGSize, _ opaque: Bool, _ scale: CGFloat)`方法生成环境. opaque: true为整个context不透明, false为可以部分透明.

得到画图环境后, UIImage的`drawInRect(_ rect: CGRect)`方法生成新的图像.

使用`UIGraphicsGetImageFromCurrentImageContext()`得到重新改变大小的图片.

关闭画图环境`UIGraphicsEndImageContext()`.

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

<br\><br\>

### Project 02 - HTTP Request and JSON
发送HTTP同步请求及JSON格式的数据处理
 
![project01](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/Project%2002%20-%20HTTP%20Request%20%26%20JSON/Project02.gif)

实现方法:

需要有一个NSURL对象来封装需要访问的url地址
 
通过该NSURL对象来生成NSRequest对象
 
需要NSResponse对象来储存访问结果
 
通过NSURLConnection来发送HTTP请求

最后通过对获取的NSData进行JSON解析

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

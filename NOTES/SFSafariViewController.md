# SFSafariViewController
项目中可能会有这样的需求：
1. 单纯的展示一个简单网页来介绍说明内容，没有其他复杂的功能
2. 不跳转到app外，保证用户留存率，且打开的网页需要拥有Safari浏览器完全功能

这时候 SFSafariViewController 就是你的最佳选择。 **PS：但是只能在iOS 9系统之后才可以使用。**

## 步骤：
### 导入头文件
```objective-c
#import <SafariServices/SafariServices.h>
```

### 声明代理
```objective-c
@interface TestViewController () <SFSafariViewControllerDelegate>

@end
```

### 初始化浏览器
```objective-c
//加载一个url，是否启用阅读器功能
SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"] entersReaderIfAvailable:YES];
safariVC.delegate = self;
[self presentViewController:safariVC animated:YES completion:nil];
```
`entersReaderIfAvailable`参数表示：如果web页面提供阅读器（Reader）功能，是否使用。

### 常用代理方法
```objective-c
@optional
/*! @abstract Delegate callback called when the user taps the Done button. Upon this call, the view controller is dismissed modally. 
*/
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller;

/*! @abstract Invoked when the initial URL load is complete.
    @param didLoadSuccessfully YES if loading completed successfully, NO if loading failed.
    @discussion This method is invoked when SFSafariViewController completes the loading of the URL that you pass to its initializer. It is not invoked for any subsequent page loads in the same SFSafariViewController instance.
 */
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully;
```

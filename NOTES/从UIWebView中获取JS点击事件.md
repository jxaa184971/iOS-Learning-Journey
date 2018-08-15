# 从UIWebView中获取JS点击事件
有些需求会要求我们获取app中打开的webview上的点击事件，获取其传过来的参数来跳转对应的页面或进行起来的一些操作。在使用UIWebView时，我们可以用以下的方法获取H5上的点击事件及其传过来的参数。

## JavaScriptCore
JavaScriptCore是webkit的一个重要组成部分，主要是对JS进行解析和提供执行环境。iOS7后苹果在iPhone平台推出，极大的方便了我们对js的操作。我们可以脱离webview直接运行我们的js。

### JSContext
JS执行的环境，同时也通过JSVirtualMachine管理着所有对象的生命周期，每个JSValue都和JSContext相关联并且***强引用***context。

### JSExport
一个协议，如果JS对象想直接调用OC对象里面的方法和属性，那么这个OC对象只要实现这个JSExport协议就可以了。


## 前提
app需要实现获取webview中的H5点击事件，H5端按钮中绑定`"onclick="window.xxName.jsClicked('参数’)`，客户端需要获取到H5调用该方法传入的参数。

## 实现方法
### 从UIWebView中获取JSContext
```objective-c
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
}
```

### 在JSContext中将JS预设好的对象绑定，window和xxName需要与H5中响应事件的JS对象名字相同
```objective-c
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"window"] = self;
    self.jsContext[@"xxName"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}
```

### 注意!!! 
上面的写法会导致互相强引用导致webview无法释放！应该将self(UIWebView)换成另外一个专门处理JS的类。

## 正确的做法
### 创建一个专门处理WebView中JS点击事件的类TPJSContextModel
在.h文件导入`JavaScriptCore`库，并且构建一个协议继承于`JSExport`, 协议名没有特殊要求。并在协议中实现与H5中按钮点击事件***方法名相同***的方法`jsClicked`。最后在.m文件中实现该方法的业务逻辑处理。
```objective-c
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol h5toAppDelegate<JSExport>
- (void)jsClicked:(NSString *)param;
@end

@interface TPJSContextModel : NSObject <h5toAppDelegate>

@end
```

### 在UIWebView代理方法中将预设好的TPJSContextModel对象设置为H5中响应事件对应的JS对象
```objective-c
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimating];
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    TPJSContextModel *jsModel = [[TPJSContextModel alloc]init];
    self.jsContext[@"window"] = jsModel;
    self.jsContext[@"xxName"] = jsModel;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}
```

通过上述方法，在webview打开对应的H5页面时，用户的点击事件及对应参数会传到`TPJSContextModel`类中对应的`jsClicked`方法中进行处理，实现H5和APP端的互通。
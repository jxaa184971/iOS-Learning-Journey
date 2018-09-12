# 从WKWebView中获取JS点击事件 

## H5端
app需要实现获取webview中的H5点击事件，H5端按钮中绑定以下js点击事件，客户端需要获取到H5调用该方法传入的参数。

注意：其中只有`methodName`可以由app端和H5端自由协商定义，其他`window.webkit.messageHandlers`与`postMessage()`均为固定格式，如果更改app端将无法识别。
```js
window.webkit.messageHandlers.methodName.postMessage(message);
```

## 创建一个专门处理WKWebView中JS点击事件的类
`WKWebView`的`configuration`属性中，有个`WKUserContentController` 类的属性`userContentController`，这个类主要用来做native与JavaScript的交互管理。

如果给`self.webview.configuration.userContentController`添加JS监听对象为`self`时会强引用循环，造成内存泄露。所以我们需要创建一个新的类专门来处理JS点击事件。

#### 导入头文件
```objective-c
#import <WebKit/WebKit.h>
```
#### WKScriptMessageHandler代理
创建一个名为TPJSContextModel的类，在.h文件中声明代理`WKScriptMessageHandler`
```objective-c
@interface TPJSContextModel : NSObject <WKScriptMessageHandler>

@end
```

#### 实现WKScriptMessageHandler代理方法
在.m文件中实现其代理方法，代理方法中`message`参数为`WKScriptMessage`类。其中的`message.name`参数表示获取的点击事件的名称，也就是上文提到的H5端和native端自定义的`methodName`。另外`message.body`参数为H5通过`postMessage()`方法传入的参数。
```objective-c
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"methodName"]) {
        NSString *parameter = message.body;
        //do your business logic here
    }
}
```

## 添加JS监听
获取WKWebView中userContentController, 并创建我们事先定义好的第三方类对象，给userContentController添加JS监听，监听者`ScriptMessageHandler`为第三方类对象，监听的js对象为事先定义好的`methodName`。
```objective-c
//添加js监听
WKUserContentController *contentController = self.webView.configuration.userContentController;
TPJSContextModel *jsContentModel = [[TPJSContextModel alloc]init];
[contentController addScriptMessageHandler:jsContentModel name:@"methodName"];
```

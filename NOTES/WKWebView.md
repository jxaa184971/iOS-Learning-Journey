# WKWebView
## 简介
WKWebView是为了解决UIWebView加载速度慢、占用内存大的问题。使用UIWebView加载网页的时候，我们会发现内存会无限增长，还有内存泄漏的问题存在。

WebKit中更新的WKWebView控件的新特性与使用方法，它很好的解决了UIWebView存在的内存、加载速度等诸多问题。

WKWebView有两个delegate, `WKUIDelegate` 和 `WKNavigationDelegate`。`WKNavigationDelegate`主要处理一些跳转、加载处理操作，`WKUIDelegate`主要处理JS脚本，确认框，警告框等。

### 简单的使用方法：

```objective-c
- (void)viewDidLoad {
        [super viewDidLoad];
        webView = [[WKWebView alloc]init];
        [self.view addSubview:webView];

        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}
```
## 基本框架

* **WKWebViewConfiguration**：这个类专门用来配置WKWebView。例如：可以设置`allowsInlineMediaPlayback` 是否支持浏览器支持视频内联播放。
    * WKPreference：这个类用来进行相关webView偏好设置。
    * WKProcessPool：这个类用来配置进程池，与网页视图的资源共享有关。
        * WKUserContentController：这个类主要用来做native与JavaScript的交互管理。
        * WKUserScript：用于进行JavaScript注入。
        * WKScriptMessageHandler：这个类专门用来处理JavaScript调用native的方法。
* **WKNavigationDelegate**：网页跳转间的导航管理协议，这个协议可以监听网页的活动。
    * WKNavigationAction：网页某个活动的示例化对象。
* **WKUIDelegate**：用于交互处理JavaScript中的一些弹出框。
* **WKBackForwardList**：堆栈管理的网页列表。
    * WKBackForwardListItem：每个网页节点对象。

## WKNavigationDelegate
##### 页面开始加载时调用 
```objective-c
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //可以用来显示loading圈
}
```

##### 当内容开始返回时调用

```objective-c
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

}
```

##### 页面加载完成之后调用
```objective-c
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //可以关闭loading圈，进行一些页面配置等
}
```

##### 页面加载失败时调用
```objective-c
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    //可以关闭loading圈，进行一些错误提示的操作
}
```

##### 接收到服务器跳转请求之后调用
```objective-c
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

}
```

##### 在收到响应后，决定是否跳转
```objective-c
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

```

##### 在发送请求之前，决定是否跳转
```objective-c
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
```

## WKUIDelegate
##### 创建一个新的WebView
当web页面需要在新窗口打开一个页面时（例如`target=_blank`）会调用此方法。通常的做法是拦截新打开的窗口页面的URL，不创建新的webview，而是调用`loadRequest`方法重新请求拦截到的URL。如下面代码所示：
```objective-c
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    [webView loadRequest:navigationAction.request];
    return nil;
}
```

##### 警告框
当web页面需要弹出警告框，会调用此方法。我可以在这个方法里面自定义需要弹出警告框的样式，completionHandler会以block的形式当做参数传回来，当用户点击确认时调用`completionHandler()`
```objective-c
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
```

##### 确认框
与警告框使用方法类似，唯一的区别是`completionHandler()`需要传入用户确认（YES）或者取消（NO）的参数。
```objective-c
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
```

##### 输入框
与确认框使用方法类似，`completionHandler()`内需要传入用户输入的字符串。
```objective-c
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
```





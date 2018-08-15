# UIWebView以及WKWebView的UA设置

### UIWebView

```objective-c
//获取原始web页面的UserAgent
UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero]; 
NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]; 

//添加自定义的UserAgent
NSString *newAgent = [oldAgent stringByAppendingString:@" Custom/1.0.0_appstore"]; 

//将新的UserAgent 
NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil]; 
[[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
```

### WKWebView的UA设置


```objective-c
@property(nonatomic, strong) WKWebView *webView;
```

```objective-c
[self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
    __strong typeof(weakSelf) strongSelf = weakSelf;
        
    NSString *userAgent = result;
    NSString *newUserAgent = [userAgent stringByAppendingString:@" WeBank-Wepower/1.0.0"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    strongSelf.webView = [[WKWebView alloc] initWithFrame:strongSelf.view.bounds];
    strongSelf.webView.allowsBackForwardNavigationGestures = YES;
    strongSelf.webView.UIDelegate = self;
    strongSelf.webView.navigationDelegate = self;
    
    if (nil != self.urlString) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        [request setTimeoutInterval:15];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [strongSelf.webView loadRequest:request];
    }
    
    [strongSelf.view addSubview:self.webView];

    // After this point the web view will use a custom appended user agent
    [strongSelf.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSLog(@"%@", result);
    }];
}];

```
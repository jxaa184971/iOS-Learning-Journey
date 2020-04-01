# NSURLSession
## 概述
`NSURLSession`，用于管理网络接口的创建、维护、删除等等工作。

在WWDC2013中，苹果团队对NSURLConnection进行了重构，并推出了NSURLSession作为替代。

NSURLSession API是**高度异步**的，如果使用系统提供的代理方法，开发者必须指定一个completion block用来将数据转换到app中。

### NSURLSessionTask
`NSURLSession`将NSURLConnection替换为`NSURLSession`和`NSURLSessionConfiguration`，以及三个`NSURLSessionTask`的子类：NSURLSessionDataTask, NSURLSessionUploadTask, 和NSURLSessionDownloadTask。

它们之间的关系如下图：
![202970c9b31922a38b99bbe834a1ea98.png](evernotecid://CA289804-EA6F-492F-90BB-2740E0F9CA46/appyinxiangcom/16579083/ENResource/p46)

`NSURLSessionTask`及三个子类继承关系：
![87eb817f3091e12668d0ca57698e2893.png](evernotecid://CA289804-EA6F-492F-90BB-2740E0F9CA46/appyinxiangcom/16579083/ENResource/p47)

`NSURLSessionDataTask`: 主要用于获取服务端的简单数据，比如JSON数据。

`NSURLSessionDownloadTask`: 主要用途是进行文件下载，它针对大文件的网络请求做了更多的处理，比如下载进度，断点续传等等。

`NSURLSessionUploadTask`: 主要是用于对服务端发送文件类型的数据使用的。

NSULRSession支持取消，重启，暂停和继续任务。
下面是NSURLSessionTask的方法：
```objective-c
// 取消
- (void)cancel;

// 暂停
- (void)suspend;

// 开始/继续
- (void)resume;
```

### NSURLSession提供的方法
取消Task：
```objective-c
// 已经存在的task将会继续执行，新的task将不再创建
- (void)finishTasksAndInvalidate;

// 与上面的方法功能大致相同，区别是即使已经存在的task也会取消。
// 注意的是，有些时候task收到-cancel的时候，task已经完成，这时是无法取消的
- (void)invalidateAndCancel;
```

## NSURLSession的使用
NSURLSession**本身是不会进行请求**的，而是**通过创建task的形式进行网络请求**（resume()方法的调用），同一个NSURLSession可以**创建多个task**，并且这些task之间的**cache和cookie是共享的**。

NSURLSession的使用有如下几步：

1. 创建NSURLSession对象
2. 使用NSURLSession对象创建Task
3. 启动任务

### 第一步：创建NSURLSession对象
直接创建
```objective-c
NSURLSession *session = [NSURLSession sharedSession];
```

配置后创建
```objective-c
[NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
```

设置加代理获得
```objective-c
// 使用代理方法需要设置代理,但是session的delegate属性是只读的,要想设置代理只能通过这种方式创建session
NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
    delegate:self
    delegateQueue:[[NSOperationQueue alloc] init]];
```

NSURLSession配置的三种类型
```objective-c
//默认配置 - 会将缓存存储在磁盘上 
+ (NSURLSessionConfiguration *)defaultSessionConfiguration; 

//瞬时会话模式 - 不会创建持久性存储的缓存 
+ (NSURLSessionConfiguration *)ephemeralSessionConfiguration; 

//后台会话模式 - 允许程序在后台进行上传下载工作 
+ (NSURLSessionConfiguration *)backgroundSessionConfigurationWithIdentifier:(NSString *)identifier
```

### 第二步：使用NSURLSession对象创建Task
NSURLSessionTask一共有三种，不同的task创建方式不同。

#### NSURLSessionDataTask
通过request对象或url创建：
```objective-c
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request; 

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url;
```

通过request对象或url创建，同时指定任务完成后通过completionHandler指定回调的代码块：
```objctive-c
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler; 

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
```

#### NSURLSessionUploadTask
通过request创建，在上传时指定文件源或数据源：
```objective-c
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL; 

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData; 

- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request;
```


通过completionHandler指定任务完成后的回调代码块：
```objective-c
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler; 

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
```

#### NSURLSessionDownloadTask

下载任务支持断点续传，第三种方式是通过之前已经下载的数据来创建下载任务：
```objective-c
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request; 

- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url; 

- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData;
```

同样地可以通过completionHandler指定任务完成后的回调代码块：
```objective-c
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler; 

- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler; 

- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;
```

我们在使用三种 task 的任意一种的时候都可以指定相应的代理。NSURLSession 的代理对象结构如下：
![d8541ba41c7e6a25d86a985d2b657624.png](evernotecid://CA289804-EA6F-492F-90BB-2740E0F9CA46/appyinxiangcom/16579083/ENResource/p48)

### 第三步：启动任务
```objective-c
// 启动任务 
[task resume];
```

## GET和POST请求

我们可以使用NSURLSessionDataTask进行GET请求与POST请求。
#### GET请求
```objective-c
//1、创建NSURLSession对象 
NSURLSession *session = [NSURLSession sharedSession];

//2、利用NSURLSession创建任务(task) 
NSURL *url = [NSURL URLWithString:@"http://www.xxx.com/login?username=myName&pwd=myPsd"]; 
NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) { 
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]); 
    //打印解析后的json数据 
    //NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]); 
}]; 

//3、执行任务 
[task resume];
```

#### POST请求
```objetive-c
//1、创建NSURLSession对象 
NSURLSession *session = [NSURLSession sharedSession];

//2、利用NSURLSession创建任务(task) 
NSURL *url = [NSURL URLWithString:@"http://www.xxx.com/login"];

//创建请求对象里面包含请求体 
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; 
request.HTTPMethod = @"POST"; 
request.HTTPBody = [@"username=myName&pwd=myPsd" dataUsingEncoding:NSUTF8StringEncoding];

NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, 
NSURLResponse * _Nullable response, NSError * _Nullable error) { 
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]); 
    //打印解析后的json数据 
    //NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]); 
];

//3、执行任务 
[task resume];
```

## 文件的上传

我们可以使用NSURLSessionUploadTask进行文件的上传

#### 以数据流的方式进行上传
这种方式好处就是大小不受限制，示例代码如下:
```objective-c
// 1.创建url 
NSString *urlString = @"http://www.xxxx.com/upload.php"; 
NSURL *url = [NSURL URLWithString:urlString]; 

// 2.创建请求 
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; 
// 文件上传使用post 
request.HTTPMethod = @"POST"; 

// 3.开始上传 request的body data将被忽略，而由fromData提供 
[[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:[NSData dataWithContentsOfFile:@"/Users/lifengfeng/Desktop/test.jpg"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) { 
    if (error == nil) { 
        NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]); 
    } else { 
        NSLog(@"upload error:%@",error); 
    } 
}] resume];
```

## 文件的下载
我们可以使用NSURLSessionDownloadTask实现文件的下载。NSURLSession使用代理方法也可以实现大文件下载，但是它实现不了断点下载，所以一般不用。
```objective-c
// 1.创建url 
NSString *urlString = [NSString stringWithFormat:@"http://www.xxx.com/test.mp3"];
// 一些特殊字符编码 
urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]; 
NSURL *url = [NSURL URLWithString:urlString];

// 2.创建请求 
NSURLRequest *request = [NSURLRequest requestWithURL:url];

// 3.创建会话，采用苹果提供全局的共享session 
NSURLSession *sharedSession = [NSURLSession sharedSession];

// 4.创建任务 
NSURLSessionDownloadTask *downloadTask = [sharedSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) { 
    if (error == nil) { 
        // location:下载任务完成之后,文件存储的位置，这个路径默认是在tmp文件夹下! 
        // 只会临时保存，因此需要将其另存 
        NSLog(@"location:%@",location.path); 

        // 采用模拟器测试，为了方便将其下载到Mac桌面 
        // NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]; 
        NSString *filePath = @"/Users/lifengfeng/Desktop/test.mp3"; 
        NSError *fileError; 

        [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:filePath error:&fileError]; 
        if (fileError == nil) { 
            NSLog(@"file save success"); 
        } else { 
            NSLog(@"file save error: %@",fileError); 
        } 
    } else { 
        NSLog(@"download error:%@",error); 
    }
}];

// 5.开启任务 
[downloadTask resume];
```

* * *

参考文章：
[https://juejin.im/entry/58aacabcac502e006973ce03](https://juejin.im/entry/58aacabcac502e006973ce03)

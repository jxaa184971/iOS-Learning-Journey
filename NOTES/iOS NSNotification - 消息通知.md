# iOS NSNotification - 消息通知

iOS消息通知机制算是同步的，观察者只要向消息中心注册， 即可接受其他对象发送来的消息，消息发送者和消息接受者两者可以互相一无所知，完全解耦。这种消息通知机制可以应用于任意时间和任何对象，观察者可以有多个，所以消息具有广播的性质。

### 优势
1. 不需要编写多少代码，实现比较简单
2. 对于一个发出的通知，多个对象能够做出反应，简单实现1对多的方式，较之于 Delegate 可以实现更大的跨度的通信机制
3. 能够传递参数（object和userInfo），object和userInfo可以携带发送通知时传递的信息

### 缺点
1. 在编译期间不会检查通知是否能够被观察者正确的处理
2. 在释放通知的观察者时，需要在通知中心移除观察者
3. 在调试的时候，通知传递的过程很难控制和跟踪
4. 发送通知和接收通知时需要提前知道通知名称，如果通知名称不一致，会出现不同步的情况
5. 通知发出后，不能从观察者获得任何的反馈信息

<br></br>
### 使用

#### 1. 通过NSNotificationCenter注册通知NSNotification
```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSecond:) name:@"Second" object:nil]; 
```    
第一个参数是观察者，第二个参数表示消息回调的方法，第三个消息通知的名字，第四个参数nil表示接受所有发送者的消息
<br></br>
回调方法
```objective-c
-(void)notificationSecond:(NSNotification *)notification{ 
        NSString *name=[notification name]; 
        NSString *object=[notification object]; 
        NSDictionary *dict=[notification userInfo]; 
        NSLog(@"名称:%@----对象:%@",name,object); 
        NSLog(@"获取的值:%@",[dict objectForKey:@"key"]); 
}
```
回调方法可以没有参数；如果有参数的话，有且只能有NSNotification一个参数。
<br></br>
#### 2. 发送通知
```objective-c
[[NSNotificationCenter defaultCenter] postNotificationName:@"Second" object:@"http://www.cnblogs.com/xiaofeixiang" userInfo:dict];
```
<br></br>
#### 3. 销毁观察者
销毁observer的所有通知的监听
```objective-c
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
```

通过名字销毁单个监听
```objective-c
[[NSNotificationCenter defaultCenter] removeObserver:self name:@"First" object:nil];
```

# 通过View寻找其所在的ViewController

### 实现原理 

所有的UIView和UIViewController都继承于UIResponder。UIResponder中有个属性`nextResponder`可以获取到下一个响应对象(一般是其上一级的UIView或UIViewController)。所以利用这个属性，我们需要做的就是找到该UIView的nextResponder，如果此nextResponder不是UIViewController则继续往下寻找下个nextResponder，直到nextResponder是UIViewController。

### 代码
```objective-c
- (UIViewController *)findViewController:(UIView *)sourceView {  
    id target = sourceView;  
    while (target) {  
        target = ((UIResponder *)target).nextResponder;  
        if ([target isKindOfClass:[UIViewController class]]) {  
            break;  
        }  
    }  
    return target;  
}  
```

# block与弱引用

block对于其调用的变量或方法都会形成强引用(strong reference)，对于self也会形成强引用。当block直接或间接的被这些变量或方法持有时（例如self），就会形成循环引用，造成内存泄露无法释放。为了防止这种情况发生，在block内部使用这些变量或方法时，需要声明为`__weak`来避免循环引用。

## weak type self
```objective-c
__weak typeof (self) weakSelf = self;
self.tapBlock = ^{
  [weakSelf dosomething];
};
```

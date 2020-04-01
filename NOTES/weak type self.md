# weak type self

一个对象的Block属性是使用copy来修饰，当Block被copy时，会对block中用到的对象产生**强引用**(ARC)或者**引用计数加一**(MRC)。当我们使用Block时,如果Block方法又引用了对象,如使用`self.`来引用对象的属性,这就会造成循环引用。

解决办法为使用__weak或者__block前缀来修饰self。
```objective-c
__weak typeof(self) weakSelf = self;

self.completeBlock = ^{
    weakSelf.completeButton.enabled = YES;
};
```

PS：只有当block作为属性被self持有，且self在block中使用才会导致循环引用。像UIView提供的animate block方法和GCD提供的一些方法是不会导致循环引用的。而且如果在block中没有使用到self，即使block作为属性被持有，也不会循环引用。

# block
## block的三种使用方法
1. block作为类的property使用
这种方式可以作为替代delegate的方式来进行消息传递。
```objective-c
//在类声明中 以Person为例
@property (nonatomic, copy) void(^blockName)();
 
//使用一
self.person.blockName = ^(){
    NSLog(@"将block当做属性值保存起来");
};

//使用二
void(^block03)() =^(){
    NSLog(@"将block当做属性值保存起来");
};
self.person.blockName = block03;
```

2. 把block当做方法的参数传入 
```objective-c
//在类声明中 以Person为例
- (void)eat:(void(^)(int count))block;

//使用
Person *p = [[Person alloc]init];
[p eat:^(int count){
    NSLog(@"吃了%d个馒头",count);
}];
```

3. 把block当做方法的返回值
```objective-c
//在类声明中 以Person为例
- (int(^)(int))run;

.m中实现
- (int(^)(int))run {
    return ^(int meter){
        NSLog(@"跑了%@米", meter);
        return meter;
    };
}

//使用
int a = self.person.run(10);
```

4. block的声明
```objective-c
//typedef声明
typedef void(^BlockName)(int b);

//类中的属性声明
@property (nonatomic, copy) BlockName block;
```
 
## block循环引用产生的原因, 以及怎么处理。
一个对象的Block属性是使用copy来修饰，当Block被copy时，会对block中用到的对象产生**强引用**(ARC)或者**引用计数加一**(MRC)。当我们使用Block时,如果Block方法又引用了对象,如使用`self.`来引用对象的属性,这就会造成循环引用。

解决办法为使用__weak或者__block前缀来修饰self。
```objective-c
__weak typeof(self) weakSelf = self;

self.completeBlock = ^{
    weakSelf.completeButton.enabled = YES;
};
```

PS：只有当block作为属性被self持有，且self在block中使用才会导致循环引用。像UIView提供的animate block方法和GCD提供的一些方法是不会导致循环引用的。而且如果在block中没有使用到self，即使block作为属性被持有，也不会循环引用。

#### 相关题目：参考如下代码，为什么block里面还需要写一个strong self？
```objective-c
__weak __typeof(self)weakSelf = self;
AFNetworkReachabilityStatusBlock callback = ^(AFNetworkReachabilityStatus status) {
   __strong __typeof(weakSelf)strongSelf = weakSelf;
   strongSelf.networkReachabilityStatus = status;
   if (strongSelf.networkReachabilityStatusBlock) {
      strongSelf.networkReachabilityStatusBlock(status);
   }
};
```
1. block外部的`__weak`修饰的self是为了打破self和block之间的循环引用，解决内存泄露的问题。
2. block内部又将weakSelf修改为`__strong`，是为了避免block回调时weak Self变成了nil，导致block运行的时候出现错误。strongSelf是防止在block执行过程中self被释放。

## block作为属性时，为什么用copy修饰？
Block在存储的时候一共有三种类型，分别是：全局block，存储在栈上的block，存储在堆上的block

* `__NSGlobalBlock__`:全局block，内部没有调用外部变量的block，直到程序结束才会被回收。
* `__NSStackBlock__`：存储在栈上的block，内部有调用外部变量的block，我们知道栈中的内存由系统自动分配和释放，作用域执行完毕之后就会被立即释放
* `__NSMallocBlock__`：存放在堆中block，作为属性且用copy修饰，需要我们自己进行内存管理。

所以如果我们使用block作为一个对象的属性，我们会使用关键字copy修饰他。如果不适用copy修饰词，这个block就会作为`__NSStackBlock__`存储在栈区。开发者没办法控制它的消亡；当我们用copy修饰的时候，系统会把该block的实现拷贝一份到堆区，这样我们对应的属性，就拥有的该block的所有权。就可以保证block代码块不会提前消亡。

## block的本质是什么？
block本质上也是一个oc对象，他内部也有一个isa指针。block是封装了**函数调用**以及**函数调用环境**的OC对象。block其实也是NSObject的子类。

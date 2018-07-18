# iOS多线程GCD简介

### Grand Central Dispatch
Grand Central Dispatch(GCD) 是异步执行任务的技术之一。开发者只需要定义想执行的任务并追加到适当的Dispatch Queue中，GCD就能生成必要的线程并计划执行任务。由于线程管理是作为系统的一部分来实现的，因此可以统一管理，也可执行任务，这样就比以前的线程更有效率。GCD用非常简洁的代码，就可以实现多线程编程。

### Dispatch Queue
Dispatch Queue是执行处理的等待队列，通过调用dispatch_async等函数，以block的形式将任务追加到Dispatch Queue中。Dispatch Queue按照添加进来的顺序（FIFO）执行任务处理。但是在任务执行处理方式上，分为Serial Dispatch Queue和Concurrent Dispatch Queue。两者的区别如表格所示:

| Dispatch Queue分类 | 说明 |
| - | - |
|Serial Dispatch Queue | 串行的队列，每次只能执行一个任务，并且必须等待前一个执行任务完成 |
|Concurrent Dispatch Queue | 一次可以并发执行多个任务，不必等待执行中的任务完成 |

### Dispatch Queue创建
在自定义创建前，我们先看看系统为我们提供的几个全局的Dispatch Queue:

| 名称 | Dispatch Queue 的种类| 说明 |
|- | - | - |
| Main Dispatch Queue | Serial Dispatch Queue |主线程执行 |
| Global Dispatch Queue (HIGH) | Concurrent Dispatch Queue |执行优先级：高 |
| Global Dispatch Queue (DEFAULT) | Concurrent Dispatch Queue | 执行优先级：默认 |
| Global Dispatch Queue (LOW) | Concurrent Dispatch Queue | 执行优先级：低 |
| Global Dispatch Queue (BACKGROUND) | Concurrent Dispatch Queue | 执行优先级：后台 |

从表格中我们可以知道我们的主线程就是Serial Dispatch Queue,而之后的三种Dispatch Queue 则是Concurrent Dispatch Queue。这也是为什么我们不能把耗时的任务放在主线程里面去操作。

#### 获取系统提供的Queue
```objective-c
//主线程 
dispatch_queue_t mainQueue = dispatch_get_main_queue(); 
//HIGH 
dispatch_queue_t highQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0); 
//DEFAULT 
dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); 
//LOW 
dispatch_queue_t lowQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0); 
//BACKGROUND 
dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
```

#### 自定义创建一个queue
```objective-c
//串行队列 
dispatch_queue_t serialQueue = dispatch_queue_create(“serialQueue", DISPATCH_QUEUE_SERIAL); 
//并发队列 
dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
```

### 使用

#### 异步执行
这个也是我们使用最多的地方，我们直接调用dispatch_async这个函数，就可以将我们要追加的任务添加到队列里面，并立即返回，异步的执行。
```objective-c
dispatch_async(queue, ^{
  NSLog(@"1");
});
```

#### 同步执行
这点我们可能用得不是很多，但是一用不好就出现问题了。当调用这个dispatch_sync函数的时候，这个线程将不会立即返回，直到这个线程执行完毕。
```objective-c
dispatch_sync(queue, ^{
  NSLog(@"2");
});
```

#### dispatch_after
在我们开发过程中经常会用到在多少秒后执行某个方法，通常我们会用这个`objective-c 
- (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay`函数。不过现在我们可以使用一个新的方法。

放到全局默认的线程里面，这样就不必等待当前调用线程执行完后再执行你的方法 
```objective-c
dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC); 
dispatch_after(delayTime,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
    //do your task 
});
```

#### dispatch_once
这个在单例初始化的时候是苹果官方推荐的方法。这个函数可以保证在应用程序中只执行指定的任务一次。即使在多线程的环境下执行，也可以保证百分之百的安全。
```objective-c
{
  static id instance; 
  static dispatch_once_t predicate; 
  dispatch_once(&predicate, ^{ 
      //your init 
  }); 
  return instance;
}
```
这里面的predicate必须是全局或者静态对象。在多线程下同时访问时，这个方法将被线程同步等待，直到指定的block执行完成。

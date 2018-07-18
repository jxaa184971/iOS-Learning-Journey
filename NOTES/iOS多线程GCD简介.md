# iOS多线程GCD简介

### Grand Central Dispatch
Grand Central Dispatch(GCD) 是异步执行任务的技术之一。开发者只需要定义想执行的任务并追加到适当的Dispatch Queue中，GCD就能生成必要的线程并计划执行任务。由于线程管理是作为系统的一部分来实现的，因此可以统一管理，也可执行任务，这样就比以前的线程更有效率。GCD用非常简洁的代码，就可以实现多线程编程。

### Dispatch Queue
Dispatch Queue是执行处理的等待队列，通过调用dispatch_async等函数，以block的形式将任务追加到Dispatch Queue中。Dispatch Queue按照添加进来的顺序（FIFO）执行任务处理。但是在任务执行处理方式上，分为Serial Dispatch Queue和Concurrent Dispatch Queue。两者的区别如表格所示

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


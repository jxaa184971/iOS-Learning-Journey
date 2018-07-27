# LLDB调试器

## LLDB简介

> LLDB 是一个有着 REPL 的特性和 C++ ,Python 插件的开源调试器。LLDB 绑定在 Xcode 内部，存在于主窗口底部的控制台中。调试器允许你在程序运行的特定时暂停它，你可以查看变量的值，执行自定的指令，并且按照你所认为合适的步骤来操作程序的进展。

## 基础

这里有一个简单的小程序，它会打印一个字符串。注意断点已经被加在第 8 行。断点可以通过点击 Xcode 的源码窗口的侧边槽进行创建。程序会在这一行停止运行，并且控制台会被打开，允许我们和调试器交互。这个控制台就是LLDB调试器。

![](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/PIC/Image_2014-11-20_at_10.01.46_PM.png)

### print
打印某个变量的值很简单，只需要在控制台输入`print`口令，例如：`print count`。 LLDB 实际上会作前缀匹配。所以你也可以使用 `prin`，`pri`，或者 `p`

### expression
当你想要改变某个变量的值的时候，你需要用到`expression`口令，例如：`expression count = 8`。 这不仅会改变调试器中的值，实际上它 ***改变了程序中的值*** 。用来调试非常方便。你也可以使用`e`来代替。

也可以用`expression`口令来声明一个变量，例如：`e int $a = 3`。需要注意的是，LLDB内的变量前面需要加上`$`符号。

### po
`po`口令(print object的缩写)，我们可以使用它来按某个对象来打印。

### watchPoint
`watchPoint`口令可以用来观测某个变量值的具体变化。比如我们要观测变量`i`的变化，只需要在控制台输入`watchpoint set variable i`，只要被检测的变量值发生改变即会被检测到。成功检测后的结果如下：

![](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/PIC/3297309-97c65603179afadc.png)

甚至可以设置变量`i`触发的条件：`watchpoint modify -c '(i=40)'` 当`i`的值变化到40时触发。

除了在控制台输入以外，也可以直接调用鼠标操作，如下图：

![](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/PIC/3297309-d86aeb5d9b683852.png)

### image
该命令用于寻址，假如程序由于某个原因崩溃掉了然而崩溃并没有给你定位到具体的信息而是直接怵在了main函数里边，此时image指令将极大的帮助你。

我在代码中制造了数组越界的崩溃。在崩溃log中看到如红箭头指向的地址，这里应该是我们代码中崩溃的地方。

![](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/PIC/1532586150084.jpg)

这时候我们可以调用`image lookup --address 0x000000010b30c668`即可定位到代码崩溃的class甚至崩溃的行数。如下图所示：

![](https://github.com/jxa184971/iOS-Learning-Journey/blob/master/PIC/1532586188518.jpg)

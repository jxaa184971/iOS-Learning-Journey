# UITextView - 超链接

## NSLinkAttributeName
想要实现文本的超链接，即点击链接跳转浏览器打开一个ULR地址，可以使用`NSLinkAttributeName`属性。该属性只能在`UITextView`中使用，来实现点击部分文字打开URL的操作。在`UILabel`和`UITextField`中是无法使用该属性的。

`NSLinkAttributeName`的对象可以是`NSURL`类型或`NSString`类型，但是推荐使用 `NSURL`。

#### 注意：
* 需要实现textView的代理方法，否则调不到回调方法。
* 需要设置textView的`editable`属性为`NO`，否则在可编辑的状态下超链接是不可点击的。

### 将全部文字设置为链接
```objective-c
NSDictionary *dictAttr = @{NSLinkAttributeName:[NSURL URLWithString:@"http://www.baidu.com"]};
NSAttributedString *attributedStr = [[NSAttributedString alloc]initWithString:@"百度" attributes:dictAttr];
textView.attributedText = attributedStr;
```

### 将部分文字设置为链接
```objective-c
NSString *str = @"跳转到百度";
NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
[attributedStr addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.baidu.com"] range:[str rangeOfString:@"百度"]];
textView.attributedText = attributedStr;
```
### 设置代理回调方法
```objetive-c
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    //在这里是可以做一些判定用来判断是否跳转
    return YES;
}
```
## 自定义超链接UI样式
如果需要在`UITextView`中自定义超链接的UI样式，可以直接修改`UITextView`中的`linkTextAttributes`属性。

### 代码样例
```objective-c
NSDictionary *linkAttributes = @{
    NSForegroundColorAttributeName: [UIColor greenColor],
    NSUnderlineColorAttributeName: [UIColor lightGrayColor],
    NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)
};

textView.linkTextAttributes = linkAttributes; 
```

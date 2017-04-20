## iOS响应链<br>

### 前言

   当我们的手指点击屏幕的时候我们的app是怎么响应的呢，当我们点击一个不规则的view的时候怎么能给这个view的不同区域设置热区呢，让我们来一起了解iOS的响应链机制。
   
### 基本概念<br>

当用户的手指点击屏幕的时候，iOS操作系统通过触摸屏获取用户的点击行为，然后把这个点击信息包装成UITouch和UIEvent形式的实例，然后找到当前运行的程序，在这个程序中逐级寻找能够响应这个事件的所有对象，然后把这些对象放入一个链表，这个链表就是iOS的响应链。<br>
下图是一个事件传递顺序从上向下传递：<br>
![](http://i1.piimg.com/567571/743b10dd0cc172c3.png)<br>
UIResponder提供了四个方法来响应点击事件：<br>

```
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
```

所以iOS中的对象想要响应事件都需要直接或间接的继承UIResponder，AppDelegate,UIApplication,UIWindow,ViewController都直接或者间接的继承了UIResponder，所以它们可以作为响应链中的对象来处理我们用户的点击事件。<br>

### 响应链形成<br>

假设我们有下面的页面：
![](http://i2.muimg.com/567571/52cc519caa13c899.png)<br>

AView上面添加了BView和CView，CView上面添加了DView，现在用户点击了DView，然后系统会接收到这个点击事件，然后调用
```
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;   
```
方法，该方法是判断点击的点是够在本对象内，如果返回true则继续调用
```
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event;
```
，返回当前的这个对象，在我们上图的这歌机构中判断顺序是这样的：<br>
1.触摸的这个点坐标在AView上吗？true，然后AView加入响应链，继续遍历AView的子页面BView和CView。<br>
2.在BView上吗？false。该分支结束。<br>
3.在CView上吗？true，CView加入响应链，继续遍历CView的子视图DView。<br>
3.在DView上吗？在,DView加入响应链，DView没有子页面，这个检测结束。<br>
经过以上检测就形成了这样一个链：AView  -->CView  -->DView。<br>
需要注意的是，响应链的建立一定是在一个subview的关系，如果只是一个页面在另一个页面上面，没有包含关系的话，这个响应链就不会传递。
证实我们的以上猜测我们可以打印一下我们这个当前页面的响应者链。

### 举例证明<br>

我们上面讲过UIResponder其中有一个方法
 ```
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
```
我们在DView中重写这个方法：

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIResponder * next = [self nextResponder];
    NSMutableString * prefix = @"--".mutableCopy;
    NSLog(@"%@", [self class]);
    
    while (next != nil) {
        NSLog(@"%@%@", prefix, [next class]);
        [prefix appendString: @"--"];
        next = [next nextResponder];
    }
}
```
打印结果如下:<br>
![](http://i2.muimg.com/567571/f4ca992e5a61ecd3.png)<br>
这就是我们刚才点击事件的响应链，第一响应者就是DView。


### 事件响应<br>

事件的传递是从上到下的，事件的响应是从下到上的。<br>

响应链已经建立起来，那么下面就该响应用户刚才的那次点击了，首先找到第一响应者DView，看他有没有处理这次点击事件，如果DView不处理就通过响应链找到它的nextResponder-CView，CView如果也不处理就会一直向上寻找，如果最终找到响应链的最后一个响应者AppDelegate也不处理，就会丢弃这次点击事件。

### 响应链的应用<br>

现在我们知道了响应链的生成过程以后我们都可以做哪些事情呢：<br>
1.更改一个对象的响应热区，通过重写对象的
```
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
```
方法可以给对象的其中一块区域添加热区。<br>
2.实现一次点击的多次响应
我们可以让当前响应对象和它的下一个响应对象同时对一次点击对象作出处
理：

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"我是d我响应le");
    //调用下一响应者的响应方法
    [super touchesBegan:touches withEvent:event];
}
```
还有很多其他的例如点击事件不响应我们的排错方法啦，等等用处可以根据我们项目的具体需求来使用。<br>
以上。
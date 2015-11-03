# - 简介
    简单地折线图绘制，这个是自己研究的在一个scrollview上绘制折线图的demo。因为吧，我觉得为了节省内存
如果画在一个layer上，肯定会节约内存一些，而且滚动起来，看起来也还流畅。这里我用了一个kvc监听（自己监听自己的属性）- -！
//创建了监听才会触发这个事件
-(void)willChangeValueForKey:(NSString *)key
值改变会走这个方法，只要简单做一些判断，key值是否是contentOffset。这样，就OK啦。有了位移事件，我们岂不是随便画咯！


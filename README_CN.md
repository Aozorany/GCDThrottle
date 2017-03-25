# GCDThrottle
![Language](https://img.shields.io/badge/language-objc-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

轻量的 GCD 封装，用于过滤太过频繁的方法调用

# 目的
使用一个时间阈值来限制方法调用频率，一共有两种过滤模式：

* GCDThrottleTypeDelayAndInvoke：拖延症模式，请求过来以后不会马上被激活，而是等待threshold秒，如果在等待时间里面还有请求过来，这个请求会被拖延，等待threshold秒再激活，以此类推。典型场景之一是在searchBar更改输入文本以后取得搜索结果。
* GCDThrottleTypeInvokeAndIgnore：贤者模式，请求过来以后会被马上激活，然后进入threshold秒的不应期，所有不应期过来的请求会被忽略，如果不应期有新的请求过来，不应期结束以后会激活这些请求中的最后一个。典型场景之一是在聊天列表中，后台数据过来的时间点不确定，而UI更新不能太过频繁，而是0.5秒或1秒更新一次。

提供了C和ObjC两种API，它们的语义是相同的。

# 用法

```objc
#import "ViewController.h"
#import "GCDThrottle.h"

@implementation ViewController

- (IBAction)textFieldValueChanged:(UITextField *)sender {
    //A: threshold 1, DelayAndInvokeMode, block invoke in main queue
    dispatch_throttle(1, ^{
        NSLog(@"A: search: %@", sender.text);
    });
    
    //B: threshold 1, DelayAndInvokeMode, block invoke in default queue
    dispatch_throttle_on_queue(1, THROTTLE_GLOBAL_QUEUE, ^{
        NSLog(@"B: search: %@", sender.text);
    });
    
    //C: threshold 1, InvokeAndIgnoreMode, block invoke in default queue
    dispatch_throttle_by_type(1, GCDThrottleTypeInvokeAndIgnore, ^{
        NSLog(@"C: search: %@", sender.text);
    });
    
    //same as A
    [GCDThrottle throttle:1 block:^{
        NSLog(@"A2: search: %@", sender.text);
    }];
    
    //same as B
    [GCDThrottle throttle:1 queue:THROTTLE_GLOBAL_QUEUE block:^{
        NSLog(@"B2: search: %@", sender.text);
    }];
    
    //same as C
    [GCDThrottle throttle:1 type:GCDThrottleTypeInvokeAndIgnore block:^{
        NSLog(@"C2: search: %@", sender.text);
    }];
}

@end
```

# 以上

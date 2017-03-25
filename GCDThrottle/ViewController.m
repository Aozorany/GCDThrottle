//
//  ViewController.m
//  GCDThrottle
//
//  Created by cyan on 16/5/24.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "ViewController.h"
#import "GCDThrottle.h"

@implementation ViewController {
    dispatch_queue_t _queue;
}

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

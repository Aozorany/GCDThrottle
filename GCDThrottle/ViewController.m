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
    
//    dispatch_throttle(1, ^{
//        NSLog(@"search: %@", sender.text);
//    });2
    _queue = dispatch_queue_create("ThrottleQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_throttle_by_type_on_queue(1, GCDThrottleTypeInvokeAndIgnore, _queue, ^{
        NSLog(@"search: %@", sender.text);
    });
}

@end

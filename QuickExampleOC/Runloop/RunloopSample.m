//
//  RunloopSample.m
//  QuickExampleOC
//
//  Created by Liam on 2021/3/29.
//

#import "RunloopSample.h"
#import <QuartzCore/QuartzCore.h>

void observerCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"Enrty, %@", [[NSRunLoop currentRunLoop] currentMode]);
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"BeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"BeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"BeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"AfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"Exit");
            break;
        case kCFRunLoopAllActivities:
            NSLog(@"AllActivities");
            break;
    }
}

//void runloopSourcePerformInfo(void *info) {
//    NSLog(@"runloopSourcePerformInfo");
//}

void RunloopSourceScheduleRoutine(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    NSLog(@"Schedule routine: source is added to runloop");
}

void RunloopSourceCancelRoutine(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    NSLog(@"Cancel Routine: source removed from runloop");
}

void RunloopSourcePerformRoutine(void *info) {
    NSLog(@"Perform Routine: source has fired");
}

@interface RunloopSample ()

@property (nonatomic, strong) NSThread *thread3;

@end

@implementation RunloopSample

- (void)start {
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, observerCallback, nil);
//    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
    
    /// source 0
//    CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL, RunloopSourceScheduleRoutine, RunloopSourceCancelRoutine, RunloopSourcePerformRoutine };
//    CFRunLoopSourceRef source = CFRunLoopSourceCreate(NULL, 0, &context);
//    CFRunLoopAddSource(CFRunLoopGetMain(), source, kCFRunLoopDefaultMode);
//
////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC),
////                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        NSLog(@"wake up");
////        CFRunLoopSourceSignal(source);
////        CFRunLoopWakeUp(CFRunLoopGetMain());
////    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC),
//                   dispatch_get_main_queue(), ^{
////__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ ()
////        CFRunLoopSourceSignal(source);
////        CFRunLoopWakeUp(CFRunLoopGetMain());
//    });

    /// source1
//    uint32_t portNum = 283489;
//    NSPort *port = [NSMachPort port];
//    [port setDelegate: self];
//    [[NSRunLoop mainRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
////    self.machPort = port;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC),
//                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"do something");
//        [port sendBeforeDate:[NSDate date] msgid:100 components:nil from:nil reserved:0];
//
//    });
    
//    [self performSelector:@selector(myMethod) onThread:[NSThread mainThread] withObject:nil waitUntilDone:false modes: @[NSDefaultRunLoopMode]];
//    [self performSelector:@selector(myMethod) withObject:[NSThread mainThread] afterDelay:0 inModes:@[kCFRunLoopDefaultMode]];
    
    // GCD
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2.0), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"test");
//    });
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"main queue task 1");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"main queue task 2");
//        });
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
//        NSLog(@"main queue task 3");
//    });
    /// 输出 1，3，2
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 5.0), dispatch_get_main_queue(), ^{
//        NSLog(@"test");
//        CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//            NSLog(@"main queue task 4");
//            CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//                NSLog(@"main queue task 5");
//                CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//                    NSLog(@"main queue task 7");
//                    CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//                        NSLog(@"main queue task 8");
//                        CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//                            NSLog(@"main queue task 9");
//                        });
//                    });
//                });
//            });
//            //            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:20]];
//            NSLog(@"main queue task 6");
//        });
//        /// 输出 4，5，6
//    });
    
//    [NSTimer scheduledTimerWithTimeInterval:5.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//            NSLog(@"main queue task 4");
//            CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//                NSLog(@"main queue task 5");
////                CFRunLoopWakeUp(CFRunLoopGetCurrent());
//                CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, ^{
//                    NSLog(@"main queue task 7");
//                });
//            });
////            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 5, false);
////            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:20]];
//            [[NSRunLoop currentRunLoop] run];
//
//            NSLog(@"main queue task 6");
//        });
//    }];
    
//    [NSTimer scheduledTimerWithTimeInterval:5.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        NSTimer *t = [NSTimer timerWithTimeInterval:0.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"test");
//        }];
//    //    timer.tolerance = 0.5;
//        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
//
//        NSLog(@"a");
//        for (int i = 0; i < 900000000; i++) {
//
//        }
//        NSLog(@"b");
//    }];
    
//    [self addBackgroundRunLoop3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTimerInBackgroundRunLoop3) name:@"myNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"myNotification" object:nil];
}

- (void)addBackgroundRunLoop3 {
    __block BOOL shouldKeepRunning = YES;
    self.thread3 = [[NSThread alloc] initWithBlock:^{
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, observerCallback, nil);
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);

//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        CFRunLoopRun();
//        while (shouldKeepRunning) {
//            @autoreleasepool {
//                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//            }
//        }
    }];
    self.thread3.name = @"addBackgroundRunLoop3";
    [self.thread3 start];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self performSelector:@selector(onTimerInBackgroundRunLoop3) onThread:self.thread3 withObject:nil waitUntilDone:NO];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        shouldKeepRunning = NO;
    });
}

- (void)onTimerInBackgroundRunLoop3 {
    NSLog(@"%@", self.thread3.name);
}

- (void)myMethod {
    NSLog(@"test");
}

- (void)handlePortMessage:(NSPortMessage *)message {
    NSLog(@"testMessage: handlePortMessage");
}

- (void)handleMachMessage:(void *)msg {
    NSLog(@"testMessage: aaaaaa");
}

@end

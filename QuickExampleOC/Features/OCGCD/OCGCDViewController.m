//
//  OCGCDViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/12.
//

#import "OCGCDViewController.h"
#import "OCRuntimeViewController.h"

/**
 GCD
 
 串行队列：在一条线程中，依次执行任务
 并行队列：在多条线程中，并行执行任务
 
 dispatch_queue_t创建过程：
 dispatch_queue_t为结构体指针，对我们而言有4个重要属性：dq_label, dq_priority, targettq, vtable
 以下简称为label, qos, tq，分别对应队列名称、优先级、目标线程
 根据串行/并行，来确定overcommit的值为0/1，然后根据qos和overcommit，来确定tq对应哪个root队列，root队列一共有12个。
 dispatch_queue_create主要就是为了完成tq的初始化。
 除此之外，vtable的赋值有两种，串行的和并行的，它会影响执行任务时的逻辑。
 
 简单地说，dispatch_sync是让当前线程对应的队列挂起，只要传入的队列不是当前串行队列，就不会造成死锁
 dispatch_async，串行队列依次在同一个线程执行，并行队列在一个或多个线程执行（根据系统的调度），即便是在同一个线程执行，也没有按照顺序执行。

 https://www.neroxie.com/2019/01/22/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3GCD%E4%B9%8Bdispatch-queue/
 */

@interface Sark : NSObject
@property (nonatomic, copy) NSString *name;
- (void)speak;
@end
@implementation Sark
- (void)speak {
    NSLog(@"my name's %@", self);
}
@end

@interface OCGCDViewController ()

@end

@implementation OCGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    id number = [OCGCDViewController alloc];
//    id a = [number initWithName:@"aa"];
//    NSLog(a);
    
    id number = [NSNumber alloc];
    id a = [number initWithBool:YES];
    
//    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_BACKGROUND, 0);
//    dispatch_queue_t queue = dispatch_queue_create("myQueue", attr);
////    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//    for (NSInteger i = 0; i < 100000; i ++) {
//        dispatch_async(queue, ^{
//            NSLog(@"%@", [NSThread currentThread]);
//        });
//    }
    
//    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(queue, ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });
    

//    [super viewDidLoad];
//    id cls = [Sark class];
//    void *obj = &cls;
//    [(__bridge id)obj speak];
    
//    NSLog(@"ViewController = %@ , 地址 = %p", self, &self);
//
//        NSString *myName = @"halfrost";
//
//        id cls = [Sark class];
//        NSLog(@"Sark class = %@ 地址 = %p", cls, &cls);
//
//        void *obj = &cls;
//        NSLog(@"Void *obj = %@ 地址 = %p", obj,&obj);
//
//        [(__bridge id)obj speak];
//
//        Sark *sark = [[Sark alloc]init];
//        NSLog(@"Sark instance = %@ 地址 = %p",sark,&sark);
//
//        [sark speak];
    
//    dispatch_queue_t queue = dispatch_queue_create("mtest", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 100; i++) {
//        dispatch_async(queue, ^{
//            NSLog(@"%d", i);
//        });
//    }
//
//    dispatch_sync(queue, ^{
//        NSLog(@"101");
//    });
}

@end

@interface LMNumber : NSObject

@end

@interface LMChildNumber : LMNumber

@end

@implementation LMNumber

- (instancetype)initWithName:(NSString *)name {
    return [[LMChildNumber alloc] init];
}

@end


@implementation LMChildNumber

@end

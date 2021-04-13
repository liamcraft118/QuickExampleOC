//
//  OCLockViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/13.
//

#import "OCLockViewController.h"

/**
 iOS中有各种锁，但平时用的都很少，为了应对面试，需要将这些锁的基本实现进行了解
 
 自旋锁
 定义bool lock，通过while(lock)申请锁，在内部分别执行lock = true, 执行任务，lock = false来完成加锁和解锁
 会有优先级反转的问题：低优先级线程加锁，导致高优先级线程忙等待，导致低优先级线程拿不到时间片，导致低优先级线程完不成任务，解不了锁。
 不适合执行耗时操作的任务，因为时间片时间有限，如果一轮没有完成任务，就要再遍历一顿，其他线程都忙等待，浪费资源。
 
 信号量
 dispatch_semaphore_t里有个value，当执行dispatch_semaphore_wait时，会将value - 1，如果结果 > 0，就直接返回，
 如果结果 <= 0，则调用lll_futex_wait()让线程进入睡眠状态，让出时间片。下一次轮训到这个线程时，再判断value值是否>0，来决定是继续睡眠还是继续执行任务。
 
 pthread_mutex
 使用方法：
 pthread_mutex_t mutex; pthread_mutexattr_t attr;
 pthread_mutex_init(&mutex, &attr) 创建锁
 pthread_mutex_lock(&mutex) 申请锁
 pthread_mutex_unlock(&mutex) 释放锁
 
 跟信号量类似，不是忙等待，阻塞线程并睡眠，然后需要进行上下文切换
 多次申请或释放锁，会导致崩溃
 pthread_mutex底层实现根据操作系统的不同而不同，一般是使用信号量，即使使用的不是信号量，也会使用lll_futex_wait()
 
 NSLock
 仅仅是对pthread_mutex的封装，使用PTHREAD_MUTEX_ERRORCHECK，用性能降低换来了错误提示，
 NSLock由于需要经过方法调用，会略慢于pthread_mutex，但由于有缓存的存在，多次调用不会有性能为。
 
 NSRecursiveLock
 也是对pthread_mutex的封装，使用类型为PTHREAD_MUTEX_RECURSIVE
 
 NSConditionLock
 生产者-消费者模型
 
 @syncronized
 OC层面的锁，本质上使用的互斥锁，底层哈希表保存了一个锁池，通过对对象进行hash之后，去取相应的锁。
 
 ref: https://juejin.cn/post/6844903446177382413
 */

@interface OCLockViewController ()

@end

@implementation OCLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end

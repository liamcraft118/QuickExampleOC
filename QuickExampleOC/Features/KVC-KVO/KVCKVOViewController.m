//
//  KVCKVOViewController.m
//  QuickExampleOC
//
//  Created by ingo on 2021/4/7.
//

#import "KVCKVOViewController.h"

@interface Foo2 : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

@implementation Foo2

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
}

@end

/**
 KVO底层实现
 设置了KVO的实例foo会指向运行时生成的子类NSKVONotifying_Foo，在set方法中，会执行NSSetIntValueAndNotify，其中会执行didChangeValueForKey，最终调用了
 observerValueForKeyPath...这个方法
 
 KVC底层实现
 [foo setValue:forKey:]
 设置时，先找setKey, _setKey，找到了调用，没找到的话，通过accessInstanceVariablesDirectly，找到key,_key,isKey,_isKey，然后赋值，
 如果还没找到，就执行setValue:forUndefindedKey: 抛出异常
 [foo valueForKey:]
 获取时，先找getKey, 没找到的话，通过accessInstanceVariablesDirectly，找到key,_key,isKey,_isKey，然后返回，
 如果还没找到，就执行valueForUndefinedKey:抛出异常
 https://juejin.cn/post/6844903747680731150
 */

@interface KVCKVOViewController ()

@end

@implementation KVCKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
 [foo addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
 执行这段代码之后，foo的类型由Foo变为FooNotify，其中会重写age的set方法，在执行setAge的时候，调用_NSSetIntValueAndNotify
 在[super didChangeValueForKey]的时候，调用的[observer observeValueForKeyPath:@"age" ofObject:foo change:change context:context]
 于是观察者便收到了foo的age变化的通知。
 */
- (void)KVOMethod {
    Foo2 *foo = [[Foo2 alloc] init];
    [foo addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:keyPath]) {
        NSLog(@"age");
    }
//    [super addObserver:observer forKeyPath:keyPath options:options context:context];
}

@end

//
//  KVCKVOViewController.m
//  QuickExampleOC
//
//  Created by ingo on 2021/4/7.
//

#import "KVCKVOViewController.h"

@interface Foo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

@implementation Foo

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
}

@end

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
    Foo *foo = [[Foo alloc] init];
    [foo addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:keyPath]) {
        NSLog(@"age");
    }
//    [super addObserver:observer forKeyPath:keyPath options:options context:context];
}

@end

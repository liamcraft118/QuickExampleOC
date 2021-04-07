//
//  OCMessageViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/7.
//

#import "OCMessageViewController.h"
#import "ToolUtils.h"
#import <objc/runtime.h>

@interface Foo1 : NSObject

@end

@implementation Foo1

- (void)functionNotExist {
    NSLog(@"functionNotExist from Foo1");
}

@end

void funcImpl() {
    NSLog(@"funcImpl");
}

@interface Foo : NSObject

@end

@implementation Foo

/*
 第一次消息转发
 [self class]返回一个Class，向这个Class里添加一个SEL为sel（即functionNotExist)，IMP为funcImpl的方法，并返回YES，
 在完成添加完方法之后，Class里的方法列表里，便会有了functionNotExist，这时候会重新走一遍objc_msgSend方法，并且找到对应的方法并执行
 这次消息转发，让自己有机会添加一个方法来执行。
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
    
    if (sel == @selector(functionNotExist)) {
        class_addMethod([self class], sel, (IMP)funcImpl, "");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

/*
 第二次消息转发
 返回值为id，即需要返回一个对象来执行functionNotExist，我们返回实现了这个方法的Foo1
 这次消息转发，让别的类来执行这个方法
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
    if (aSelector == @selector(functionNotExist)) {
        return [[Foo1 alloc] init];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

/*
 第三次消息转发
 返回方法签名NSMethodSignature，这里面保存的是方法的参数以及返回值类型，
 接下来的NSInvocation在初始化时，会使用这个方法签名，以及发起请求的selector，
 这次消息转发可以让任何类型来执行任何方法。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(functionNotExist)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    Foo1 *foo1 = [[Foo1 alloc] init];
    if ([foo1 respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:foo1];
    }
}

/*
 总结：
 第一次消息转发：给自己一个机会，利用runtime的API添加执行的方法（SEL）以及实现（IMP），并返回YES，然后会重新执行objc_msgSend，最终自己执行这个方法
 第二次消息转发：给别人一个机会，如果其他类能够执行这个方法的话，返回这个类的实例去执行
 第三次消息转发：大家自由发挥，先返回一下方法签名，表示你心目中的方法的返回值、参数的类型，然后NSInvocation会用这个数据以及之前的sel进行初始化，最后你可以用anInvocation或者不用，执行其他方法，都行
 */

@end


/**
 OC消息机制
 消息机制源于runtime，这里不对runtime做过多的解释
 */

@interface OCMessageViewController ()

@end

@implementation OCMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self runtimeSendMessage];
}

/*
 在下面的例子中，[str length]在底层会执行，objc_msgSend(str, @selector(length))，
 然后会在str的方法列表中，找到length方法，以及这个方法对应的实现IMP，最终从IMP指向的地址开始执行任务，
 然后把方法加到cache中，下一次执行这个方法时，查询的速度就会变快
 
 除了正常的消息发送流程外，还有三次消息转发流程
 当str执行functionNotExist时，会从str的类、父类一直查看是否存在这个方法，当都不存在时，进行消息转发
 */
- (void)runtimeSendMessage {
    NSString *str = [[NSString alloc] init];
    NSInteger length = [str length];
    LMLOG_INT(length)
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    Foo *foo = [[Foo alloc] init];
    [foo performSelector:@selector(functionNotExist)];
#pragma clang diagnostic pop
}

@end

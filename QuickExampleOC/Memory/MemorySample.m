//
//  MemorySample.m
//  QuickExampleOC
//
//  Created by Liam on 2021/3/8.
//

#import "MemorySample.h"
#import "ToolUtils.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

void testIMP(id self, SEL _cmd) {
    NSLog(@"dynamic forward");
}

@interface People : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;

@end

@interface People ()

@end

@implementation People

@end

@interface Student : People

@end

@implementation Student


@end


int age = 24;//全局初始化区（数据区）
NSString *name;//全局未初始化区（BSS区）
static NSString *sName = @"Dely";//全局（静态初始化）区

@interface MemorySample ()

@property (nonatomic, assign) NSInteger instantceInt;
@property (nonatomic, copy) NSString *instantceStr;
@property (nonatomic, strong) NSString *age;

@end


@implementation MemorySample

- (void)start {
    // debug模式下不会立马释放
    // ref: https://stackoverflow.com/a/26583061/4789773
//    NSNumber __weak *number = [[NSNumber alloc] initWithInt:100];
//    NSLog(@"number = %@", number);
    
//    NSString *a = @"test";
//    NSLog(@"a = %@\n%p\n%p", a, a, &a);
//    NSMutableString *b = [a mutableCopy];
//    NSLog(@"b = %@\n%p\n%p", b, b, &b);
//
////    NSMutableString *aStr = [NSMutableString stringWithFormat:@"aaa"];
//    NSMutableString *aStr = [NSMutableString stringWithString:@"0123456789"];
//    NSString *bStr = [aStr copy];
//    NSMutableString *cStr = [aStr mutableCopy];
//    NSLog(@"aStr = %@\n%p\n%p", aStr, aStr, &aStr);
//    NSLog(@"bStr = %@\n%p\n%p", bStr, bStr, &bStr);
//    NSLog(@"bStr = %@\n%p\n%p", cStr, cStr, &cStr);
//
//    NSString *m = [NSString stringWithFormat:@"01234567899"];
//    NSLog(@"m = %@\n%p\n%p", m, m, &m);
//    NSString *n = m;
//    NSLog(@"n = %@\n%p\n%p", n, n, &n);
    
//    self.instantceInt = 0;
//    self.instantceStr = @"a";
//    LMLOG_INT(_instantceInt)
//    LMLOG(_instantceStr)

//    void (^tmpBlock)(void) = ^ {
//        NSLog(@"aaa");
//    };
//    [ToolUtils Log:tmpBlock];
//    LMLOG(tmpBlock)

//    typeof(self) __weak weakSelf = self;
//    NSString *name = @"myName";
//    NSInteger foo = 2;
//    __block NSInteger age = 1;
//    LMLOG_INT(foo)
//    LMLOG_INT(age)
//    LMLOG(name);
//    LMLOG(weakSelf)
//
//    void (^contentBlock)(void) = ^ {
//        age = 4;
//        LMLOG_INT(foo)
//        LMLOG_INT(age)
//        LMLOG(name);
//        LMLOG(weakSelf)
//    };
//    LMLOG(contentBlock)
//    contentBlock();
//
//    LMLOG_INT(age);
    
//    __block NSInteger age = 0;
//    __weak void (^myBlock)(void) = ^ {
//        NSLog(@"%ld", age);
//    };
//    LMLOG(myBlock);
//
//    NSLog(@"%@", ^ { NSLog(@"%ld", age);});
    
//    __weak NSMutableString *str = [NSMutableString stringWithFormat:@"aaa"];
//    LMLOG(str)
//    NSString *newStr = [str copy];
//    LMLOG(newStr);
    
//    NSObject *obj = [[NSObject alloc] init];
//    LMLOG(obj);
//    NSLog(@"%p", [NSObject class]);
//
//    People *people = [[People alloc] init];
//    LMLOG(people);
//
//    NSLog(@"%zd", class_getInstanceSize([People self]));
//    NSLog(@"%zd", malloc_size((__bridge const void *)people));
    
//    People *people = [[People alloc] init];
//    [people addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
//    NSLog(@"%@", people);
//
//    NSDictionary *dict = @{};
//    unsigned int outCount = 0;
//    Ivar *ivars = class_copyIvarList([People self], &outCount);
//    for (int i = 0; i < outCount; i++) {
//        Ivar ivar = ivars[i];
//        const char *name = ivar_getName(ivar);
//        const char *type = ivar_getTypeEncoding(ivar);
//        NSLog(@"name = %s, type = %s", name, type);
//    }
    
    People *object1 = [[People alloc] init];
    __block People *object2 = [[People alloc] init];
    object1.name = @"Mike";
    object2.name = @"Sean";
    __block int vi = 1;

    void (^handler)(NSString *) = ^(NSString *name) {
        object1.name = name;
        object2.name = name;
        vi = 2;
    };
    handler(@"Lucy");

    NSLog(object1.name);
    NSLog(object2.name);
    NSLog(@"%i", vi);
    
    
    
    /*
     说下你在开发过程中遇到过的内存泄漏
     NSTimer 怎么处理内存泄漏
     Delegate什么情况下会出现内存泄漏，怎么解决
     Delegate和Notification的区别
     多线程相关
     iOS中有哪些多线程技术
     如果有两个同步任务嵌套会怎样
     常见的锁，为什么要加锁
     C依赖AB任务执行完才能执行，你怎么设计
     读写锁底层怎么实现
     JavaScriptCore相关
     什么是JavaScriptCore，JS和Native是怎么进行通信的
     你知道hybrid么，说说你平常怎么使用的（因为没怎么接触过直接说的不会）
     后面就是聊天了，中间穿插问了下动态库和静态库的却别
     */
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)dealloc {
}

- (void)memoryStorage {
    
    int tmpAge;//栈
    NSString *tmpName = @"Dely";//栈
    NSString *number = @"123456"; //123456\\\\0在常量区，number在栈上。
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];//分配而来的8字节的区域就在堆中，array在栈中，指向堆区的地址
    NSInteger total = [self getTotalNumber:1 number2:1];
}

- (NSInteger)getTotalNumber:(NSInteger)number1 number2:(NSInteger)number2{
    return number1 + number2;//number1和number2 栈区
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    class_addMethod(self, sel, (IMP)testIMP, "v:");
//    return YES;
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return nil;
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//}

//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    return [anInvocation invokeWithTarget: ];
//}

@end

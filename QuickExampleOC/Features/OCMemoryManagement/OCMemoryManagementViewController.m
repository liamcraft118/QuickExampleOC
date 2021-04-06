//
//  OCMemoryManagementViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/6.
//

/**
 OC的内存管理
 
 什么是内存管理，为什么需要内存管理？
 在执行任务时，需要占用内存，所以需要在合适的时候释放这些内存。
 在执行大量任务时，需要占用大量内存，所以需要合理优化内存的使用。
 这些都是内存管理的目的。
 参考：https://cloud.tencent.com/developer/article/1139869
 
*/
#import "OCMemoryManagementViewController.h"
#import "ToolUtils.h"
#import "Person.h"

@interface OCMemoryManagementViewController ()

@end

@implementation OCMemoryManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OCMemory";
    
    [self heapAndStack];
    [self automaticReferenceCounting];
    [self properties];
    [self myAutoreleasePool];
    [self myBlock];
}

/**
 哪些对象需要进行内存管理？
 继承了NSObject的需要，其他不需要，比如int、char、float、double、struct、enum.
 因为NSObject存储在**堆**，而基础数据结构存储在**栈**。
 下面代码中 a, str, p指针都会被回收，但Person实例在堆中没有释放（MRC时）
 */
- (void)heapAndStack {
    NSInteger a = 10; // 指针在栈上，指针指向低内存地址，占8字节
    LMLOG_INT(a)
    
    NSString *str = @"constant str"; // 字符串在常量区
    LMLOG(str)

    Person *p = [[Person alloc] init]; // Person对象在堆
    LMLOG(p);
    
    // 帧栈入栈
//    [self frameStack];
    // 帧栈出栈
}

/**
 alloc/new/copy会创建并持有一个对象，引用计数为1
 release会将对象的引用计数-1
 当对象的引用计数为0，系统会回收这块内存，对象会执行dealloc。在回收之后，这个对象会成为僵尸对象，指向僵尸对象的指针成为野指针。
 内存管理规则：1.自己生成自己持有 2.非自己生成，也可持有 3.非自己持有，则无需释放 4
 */
- (void)manualReferenceCounting {
//    NSString *str1 = [[NSString alloc] init]; 自己生成自己持有
//    [str1 release]; 自己释放
    
//    NSString *str2 = [NSString stringWithFormat:@""];
//    [str2 retain]; 非自己生成也可持有
//    [str2 release]; 自己释放
    
//    NSString *str3 = [NSString stringWithFormat:@""]; 自己不持有，无需释放
//    stringWithFormat内部执行 return [str autorelease] 将内部创建的字符串加入自动释放池中
}

/**
 自动加入retain, release, autorelease
 __strong修饰的指针所持有的对象，都会自动retain，所有指针默认都是__strong修饰
 */
- (void)automaticReferenceCounting {
    // 这两种写法等价
    NSString *str1 = [[NSString alloc] init]; // 等价于 __strong NSString *str1 = [[NSString alloc] init];
    LMLOG(str1)
    
    // 这里会有一个warning: Assigning retained object to weak variable; object will be released after assignment
    // 在debug模式下str2会拿到正常值，但在release模式下，str2为nil
    __weak NSString *str2 = [[NSString alloc] init];
}

/**
 properties一共有12个
 retain, strong, weak, unsafed_unretained, assign, copy,
 getter, setter, readonly, readwrite, atomic, nonatomic
 */
- (void)properties {
    /*
     比较重要的6个 retain, strong, unsafe_unretained, assign, weak, copy
     前四个比较简单，本质上是自动合成set方法时，要不要持有的区别
     其中ARC中strong代替retain，作用相同
     unsafe_unretained与assign作用相同，不过iOS4之前只有unsafe_unretained
     */
    
    /*
     weak
     weak与assign相同，除了对象释放后，有机制确保weak指针指向nil
     weak对象释放后，weak指针指向nil的机制：
     对weak指针进行赋值时，以对象作为key，将weak指针加入到对应的数组中，
     当对象引用计数为零时，从字典中取出数组，遍历数组，让其中的指针都指向nil
     */
    
    /*
     copy
     copy涉及到深复制与浅复制https://www.jianshu.com/p/b5c29663a4c9
     浅复制：新建一个指针，指向之前的数组
     深复制：新建一个指针，指向一个新的数组，数组中新建的指针指向之前的内容
     原则1
     NSMutableString的copy和mutableCopy都是深复制
     而NSString的copy是浅复制，mutableCopy是深复制

     原则2
     当对NSObject对象执行copy/mutablecopy时，看NSObject自身实现的(mutable)copyWithZone。
     
     原则3
     当对持有NSObject对象的NSArray/NSMutableArray执行copy/mutablecopy时，本质上就是对NSArray/NSMutableArray执行copy/mutablecopy，所以依然遵循原则1，
     浅复制时，新建指针指向之前的数组
     深复制时，新建指针指向新的数组，数组中新建的指针指向之前的内容
     跟原则1一致
     */
    
    // 定义
//    @interface DBTestModel : MTLModel
//
//    @property (nonatomic, copy) NSString *text;
//
//    @property (nonatomic, strong) NSArray *sourceArray;
//
//    @property (nonatomic, strong) NSMutableArray *mutableArray;
//
//    - (instancetype)initWithText:(NSString *)text
//                     sourceArray:(NSArray *)sourceArray
//                    mutableArray:(NSMutableArray *)mutableArray;
//    @end
    
    // 执行
//    NSMutableArray *mutableArray = [NSMutableArray array];
//        DBTestModel *model = [[DBTestModel alloc] initWithText:@"text"
//                                                   sourceArray:@[@"test1",@"test2"]
//                                                  mutableArray:mutableArray];
//        DBTestModel *copyModel = [model copy];
//        DBTestModel *mutaCopyModel = [model mutableCopy];
//
          // 三个都不同，因为类中有属性进行了深复制
//        NSLog(@"original   :%p", model);
//        NSLog(@"copy       :%p", copyModel);
//        NSLog(@"mutableCopy:%p", mutaCopyModel);
    
          // 1、2相同， 3不同，因为2为浅复制，3为深复制
//        NSLog(@"original   :%p", model.text);
//        NSLog(@"copy       :%p", copyModel.text);
//        NSLog(@"mutableCopy:%p", mutaCopyModel.text);
    
          // 1、2相同，3不同，因为2为浅复制，3为深复制
//        NSLog(@"original   :%p", model.sourceArray);
//        NSLog(@"copy       :%p", copyModel.sourceArray);
//        NSLog(@"mutableCopy:%p", mutaCopyModel.sourceArray);
    
          // 都不同，因为2、3均为深复制
//        NSLog(@"original   :%p", model.mutableArray);
//        NSLog(@"copy       :%p", copyModel.mutableArray);
//        NSLog(@"mutableCopy:%p", mutaCopyModel.mutableArray);
}

- (void)myAutoreleasePool {
    /*
     1. 用于循环中
     2. 用于长时间的后台任务中
     目的都是及时释放内存
     */
    
    // ARC中如何能够提前释放内存？
    @autoreleasepool {
        NSString *str = [[NSString alloc] init];
        LMLOG(str)
    }
    // str会在作用于结束之后释放，而不是全局autoreleasepool清理时
}

- (void)myBlock {
    // 不捕获任何变量
    void (^globalBlock)(void) = ^{
        NSLog(@"global block");
    };
    LMLOG(globalBlock);
    
    /*
     age作为形参传入，复制一份到堆中
     age1在mallocBlock初始化之后，就会将age1的值复制到堆中，然后让age1指向堆中的地址
     age2虽然有__block修饰，但却没有被用到，实际上依然保存在栈中
     对于person而言，如果需要重新复制给person，比如在block中执行person = [[Person alloc] init]，则也需要加__block，
     这样person1的指针就会复制到堆上去
     */
    NSInteger age = 10;
    __block NSInteger age1 = 20;
    __block NSInteger age2 = 30;
    Person *person = [[Person alloc] init];
    __block Person *person1 = [[Person alloc] init];
    void (^mallocBlock)(void) = ^{
        NSLog(@"age = %ld, %ld", age, age1);
        LMLOG(person1)
    };
    LMLOG_INT(age2)
    LMLOG(person)

    LMLOG(mallocBlock)
    mallocBlock();
    
    // MRC中会有stackBlock
//    __weak void (^stackBlock)(void) = ^{
//    };
//    LMLOG(stackBlock);
}

@end

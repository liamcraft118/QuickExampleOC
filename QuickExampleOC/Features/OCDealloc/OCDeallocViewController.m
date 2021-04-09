//
//  OCDeallocViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/8.
//

#import "OCDeallocViewController.h"

/**
 dealloc具体分为三个过程
 1. 类声明过属性或实例变量，dealloc时会执行objc_cxxDestruct(obj)
 2. Class中有关联对象，dealloc会执行_object_remove_assocations()
 3. 有弱引用或者sideTable的时候，dealloc会执行clearDeallocating()
 
 dealloc易犯的错：
 1. dealloc是在release之后触发，而执行release所在的线程就是dealloc执行的线程
 2. dealloc方法中调用属性，避免使用self.name = nil，而是_name = nil
 3. dealloc中使用__weak，__weak会将指针存储在字典中，当执行storeWeak时，判断如果在释放过程中，会直接崩溃。
 
 ref:
 https://www.jianshu.com/p/44f2ef4552a8
 https://gitkong.github.io/2019/10/24/ARC%E4%B8%8B-Dealloc%E8%BF%98%E9%9C%80%E8%A6%81%E6%B3%A8%E6%84%8F%E4%BB%80%E4%B9%88/
 */

@interface OCDeallocViewController ()

@end

@implementation OCDeallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end


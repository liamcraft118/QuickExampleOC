//
//  OCRuntimeViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/8.
//

#import "OCRuntimeViewController.h"
#import <objc/runtime.h>

/**
 Runtime能做哪些事情？
 KVO，在运行时新建了一个子类。
 消息转发，先发送消息，没有类能处理时进行消息转发，1. 运行时新建一个方法 2. 换个类的实例来执行这个方法 3. 实现任意逻辑
 关联对象，将key, value保存到target类的关联对象列表中
 Method Swizzliing，添加、替换selector对应的IMP
 字典转模型，取出属性列表，取出属性的名字作为key，通过key从dict中取到value，利用KVO为model的各个属性赋值
 */
@interface OCRuntimeViewController ()

@end

@implementation OCRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

void funcImpl0() {
    
}

- (void)startRuntime {
    objc_setAssociatedObject(self, "key", @"value", OBJC_ASSOCIATION_RETAIN);
    objc_getAssociatedObject(self, "key");
    
    unsigned int count;
    class_copyMethodList([self class], &count);
    class_copyIvarList([self class], &count);
    class_copyPropertyList([self class], &count);
    
    class_replaceMethod([self class], @selector(sel), (IMP)funcImpl0, "v@:");
    class_addMethod([self class], @selector(sel), (IMP)funcImpl0, "v@:");
}

@end

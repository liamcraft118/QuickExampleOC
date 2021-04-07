//
//  OCStructViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/6.
//

#import "OCStructViewController.h"

/**
 OC类的结构
 OC的结构涉及到c语言的一系列代码，这里进行一个简单地了解
 
 参考：https://juejin.cn/post/6844904055047716878
 
*/

@interface OCStructViewController ()

@end

@implementation OCStructViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OCStruct";
}

/*
 NSObject本质上是objc_object这个结构体，objc_object主要包含一个属性isa_t isa，以及其他的函数：
 关于isa的函数，如initIsa()、getIsa()、changeIsa()等
 关于弱引用的函数，如isWeaklyReferenced()、setWeaklyReferenced_nolock()等
 关于内存管理函数，如retain()、release()、autorelease()等
 关于关联对象函数，分别是hasAssociatedObjects()和setHasAssociatedObjects
 
 isa一般而言是一个Class，而Class本质上是objc_class的指针，而objc_class继承自objc_object，objc_class包含：
 Class superclass;
 cache_t cache;
 class_data_bits_t bits;
 因为继承于objc_object，objc_class还包含isa，那么我们的类objc_class本质上就是一个包含自身类型、父类型的一个对象objc_object，而objc_object就是包含一个类型isa的对象。
 
 isa详情看https://juejin.cn/post/6844904053277720584
 cache详情看https://juejin.cn/post/6844904070596001806
 
 回到objc_class中的bits，bits本质上是class_rw_t，其中包含：
 class_ro_t、方法列表、属性列表、协议列表，
 其中class_to_t的结构与class_rw_t类似，但包含的是编译期确定的方法列表、属性列表、协议列表，
 
 至此我们归纳一下，什么是NSObject？
 NSObject实例是objc_object，NSObject类是objc_class，
 NSObject实例包含了isa、弱引用、内存管理、关联对象相关的函数，其中isa代表了自己所属的类，
 NSObject类包含了superClass、cache、class_rw_t，其中class_rw_t包含了方法列表、属性列表、协议列表
 
 举个例子，当NSObject执行foo方法时，会从isa中找，isa即objc_class，其中包含了方法列表，如果没有找到，可以从superClass中找，如此往复
 */

@end

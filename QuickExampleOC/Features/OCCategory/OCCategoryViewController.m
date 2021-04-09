//
//  OCCategoryViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/8.
//

#import "OCCategoryViewController.h"

/**
 Category和Extension
 
 Extension是在编译器执行，所以可以添加实例变量，extension的主要作用：
 1. 隐藏类的私有信息
 
 Category是在运行时执行，能够添加：
 1. 实例方法
 2. 类方法
 3. 协议
 4. 属性
 但是不能添加实例变量
 添加属性时，不会自动合成，并且需要添加@dynamic关键字，换句话说，也只能添加set/get方法
 
 category中的实例方法、协议、属性，会在运行时被添加到Class中，而类方法会被添加到MetaClass中，
 其中方法的添加，只是将category中的方法加到了Class中方法列表的前面，所以会出现同名方法，category方法会覆盖原方法的情况
 
 ref: https://tech.meituan.com/2015/03/03/diveintocategory.html
 */

@interface OCCategoryViewController ()

@end

@implementation OCCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end

@protocol MyProtocol <NSObject>

- (void)myProtocolMethod;

@end

@interface OCCategoryViewController (MyCatetory) <MyProtocol>

@property (nonatomic, copy) NSString *name;

@end

@implementation OCCategoryViewController (MyCatetory)
//@synthesize name = _name;
@dynamic name;

+ (void)myClassMethod {
    
}

- (void)myMethod {
    
}

- (void)myProtocolMethod {
    
}

@end

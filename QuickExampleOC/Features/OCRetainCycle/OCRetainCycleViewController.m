//
//  OCRetainCycleViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/8.
//

#import "OCRetainCycleViewController.h"

/**
 retain cycle
 
 引起循环引用的根本原因是相互强引用：
 1. delegate，A持有B，B持有A
 2. block，A持有block，block持有A
 3. NSTimer，A持有timer，timer持有A，解决方法：
 vc持有weakProxy和timer,weakProxy弱引用vc，timer添加target为weakProxy（即向weakProxy发消息），weakProxy转发消息回vc，
 这样vc没有其他强引用，它自己可以释放，然后timer可以释放，然后weakProxy可以释放
 */

@interface OCRetainCycleViewController ()

@end

@implementation OCRetainCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

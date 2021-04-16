//
//  ChildViewViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/14.
//

#import "ChildViewViewController.h"
#import "TouchDebugView.h"

@interface ChildViewViewController ()

@end

@implementation ChildViewViewController

- (void)loadView {
    TouchDebugView *aView = [[TouchDebugView alloc] init];
    aView.backgroundColor = UIColor.systemGrayColor;
    aView.frame = UIScreen.mainScreen.bounds;
    self.view = aView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"child viewController touchBegan");
    [super touchesBegan:touches withEvent:event];
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

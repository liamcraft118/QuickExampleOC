//
//  ViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/3/4.
//

#import "ViewController.h"
#import "StartSampleManager.h"
#import "TouchDebugView.h"

@interface ViewController ()

@property (nonatomic, strong) StartSampleManager *startSampleManager;

@property (nonatomic, copy) NSArray<UIView *> *viewCollections;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *pinkView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _startSampleManager = [[StartSampleManager alloc] init];
    [_startSampleManager start];
    
    TDTapGestureRecognizer *blueTap = [[TDTapGestureRecognizer alloc] initWithTarget:self action: @selector(tapAction:)];
    blueTap.myName = @"blueTap";
    TouchDebugView *blueView = [[TouchDebugView alloc] initWithFrame:CGRectMake(100, 100, 250, 400)];
    blueView.backgroundColor = UIColor.systemBlueColor;
    blueView.name = @"blue";
//    [blueView addGestureRecognizer:blueTap];
    [self.view addSubview:blueView];
    
    TDTapGestureRecognizer *grayTap = [[TDTapGestureRecognizer alloc] initWithTarget:self action: @selector(tapAction:)];
    grayTap.myName = @"grayTap";
    TouchDebugView *grayView = [[TouchDebugView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    grayView.backgroundColor = UIColor.systemGrayColor;
    grayView.name = @"gray";
//    [grayView addGestureRecognizer:grayTap];
    [blueView addSubview:grayView];
    
    TDTapGestureRecognizer *tealTap = [[TDTapGestureRecognizer alloc] initWithTarget:self action: @selector(tapAction:)];
    TDTapGestureRecognizer *tealTapA = [[TDTapGestureRecognizer alloc] initWithTarget:self action: @selector(tapAction:)];
    tealTap.myName = @"tealTap";
    tealTapA.myName = @"tealTapA";
    [tealTapA setNumberOfTapsRequired:2];
    TouchDebugView *tealView = [[TouchDebugView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    tealView.backgroundColor = UIColor.systemTealColor;
    tealView.name = @"teal";
//    [tealView addGestureRecognizer:tealTap];
    [tealView addGestureRecognizer:tealTapA];
    [grayView addSubview:tealView];
    
//    TDTapGestureRecognizer *orangeTap = [[TDTapGestureRecognizer alloc] initWithTarget:self action: @selector(tapAction:)];
    UILongPressGestureRecognizer *orangeTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action: @selector(tapAction:)];
//    orangeTap.myName = @"orangeTap";
    TouchDebugView *orangeView = [[TouchDebugView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    orangeView.backgroundColor = UIColor.systemOrangeColor;
    orangeView.name = @"orange";
//    [orangeView addGestureRecognizer:orangeTap];
    [tealView addSubview:orangeView];

    TouchDebugView *pinkView = [[TouchDebugView alloc] initWithFrame:CGRectMake(150, 0, 100, 100)];
    self.pinkView = pinkView;
    pinkView.backgroundColor = UIColor.systemPinkColor;
    pinkView.name = @"pink";
//    [grayView addGestureRecognizer:tap];
    [blueView addSubview:pinkView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 100, 100, 100);
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.systemGreenColor forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
//    [blueView addSubview:button];
    
    _viewCollections = blueView.subviews;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegain %s", __func__);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesMoved %s", __func__);
    UITouch *touch = touches.allObjects[0];
    
    for (TouchDebugView *target in _viewCollections.objectEnumerator) {
        CGPoint point = [touch locationInView:target];
        if ([target pointInside:point withEvent:event]) {
            [target changeBackgroundColor];
        } else {
            [target restoreBackgroundColor];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded %s", __func__);
    
    UITouch *touch = touches.allObjects[0];
    for (TouchDebugView *target in _viewCollections.objectEnumerator) {
        CGPoint point = [touch locationInView:target];
        if ([target pointInside:point withEvent:event]) {
            [target restoreBackgroundColor];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesCancelled %s", __func__);
}

- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches {
    NSLog(@"touchesEstimatedPropertiesUpdated %s", __func__);
}

- (void)tapAction:(TDTapGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStatePossible:
            NSLog(@"possible");
            break;
        case UIGestureRecognizerStateBegan:
            NSLog(@"began");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"changed");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"ended");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"cancel");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"fail");
            break;
    }
    
    int a = 0;
}

@end

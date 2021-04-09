//
//  MyView.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/8.
//

#import "MyView.h"

/**
 layer在被标记为dirty时（setNeedsDisplay)，layer会执行display，
 里面先尝试执行[delegate displayLayer:layer]，这个方法里，我们可以给layer设置contents，如果这个方法存在，后面的方法都不会再执行。
 如果方法不存在，layer会执行drawInContext:context，这个方法里面会执行[delegate drawLayer:inContext:]，这个方法会执行[self drawRect:]
 最终生成寄宿图赋值给layer.contents
 */

@implementation MyView

+ (Class)layerClass {
    NSLog(@"layerClass");
    return MyLayer.self;
}

//- (void)displayLayer:(CALayer *)layer {
//    NSLog(@"displayLayer");
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"drawlayer in context");
    [super drawLayer:layer inContext:ctx];
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 50, 50));
    CGContextSetFillColorWithColor(context, UIColor.systemGrayColor.CGColor);
    CGContextFillPath(context);
    
    NSLog(@"finish");
}

@end

@implementation MyLayer

- (void)display {
    NSLog(@"display");
    [super display];
}

- (void)drawInContext:(CGContextRef)ctx {
    NSLog(@"drawInContext");
    [super drawInContext:ctx];
}

@end

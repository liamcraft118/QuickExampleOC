//
//  TouchDebugView.m
//  QuickExampleOC
//
//  Created by Liam on 2021/3/30.
//

#import "TouchDebugView.h"

@interface TouchDebugView ()

@property (nonatomic, strong) UIColor *prevColor;

@end

@implementation TouchDebugView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@: touchesBegain %@", NSStringFromClass([self class]), _name);
//    [super touchesBegan:touches withEvent:event];
    
}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    NSLog(@"%@: touchesMoved %@", NSStringFromClass([self class]), _name);
//    UITouch *touch = touches.allObjects[0];
//    CGPoint point = [touch locationInView:self];
//    if (![self pointInside:point withEvent:event]) {
//        [super touchesCancelled:touches withEvent:event];
//    }
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    NSLog(@"%@: touchesEnded %@", NSStringFromClass([self class]), _name);
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    NSLog(@"%@: touchesCancelled %@", NSStringFromClass([self class]), _name);
//}
//
//- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches {
////    NSLog(@"%@: touchesEstimatedPropertiesUpdated %@", NSStringFromClass([self class]), _name);
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@, hitTest %@", NSStringFromClass([self class]), _name);
//    NSLog(@"point = %@", NSStringFromCGPoint(point));
    return [super hitTest:point withEvent:event];
//    if ([self pointInside:point withEvent:event]) {
//        return self;
//    } else {
//        return nil;
//    }
}

- (void)changeBackgroundColor {
    if (_prevColor == nil) {
        _prevColor = self.backgroundColor;
    }
    self.backgroundColor = UIColor.systemOrangeColor;
}

- (void)restoreBackgroundColor {
    if (_prevColor == nil) {
        _prevColor = self.backgroundColor;
    }
    self.backgroundColor = _prevColor;
}

@end

@implementation TDTapGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@: touchesBegain %@", NSStringFromClass([self class]), _myName);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@: touchesMoved %@", NSStringFromClass([self class]), _myName);
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@: touchesEnded %@", NSStringFromClass([self class]), _myName);
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@: touchesCancelled %@", NSStringFromClass([self class]), _myName);
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches {
    NSLog(@"%@: touchesEstimatedPropertiesUpdated %@", NSStringFromClass([self class]), _myName);
    [super touchesEstimatedPropertiesUpdated:touches];
}

@end

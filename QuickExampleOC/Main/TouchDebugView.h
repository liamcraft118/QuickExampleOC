//
//  TouchDebugView.h
//  QuickExampleOC
//
//  Created by Liam on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TouchDebugView : UIView

@property (nonatomic, copy) NSString *name;

- (void)changeBackgroundColor;
- (void)restoreBackgroundColor;

@end


@interface TDTapGestureRecognizer : UITapGestureRecognizer

@property (nonatomic, copy) NSString *myName;

@end

NS_ASSUME_NONNULL_END

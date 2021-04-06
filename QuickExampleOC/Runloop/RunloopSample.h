//
//  RunloopSample.h
//  QuickExampleOC
//
//  Created by Liam on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunloopSample : NSObject <NSMachPortDelegate, NSPortDelegate>

- (void)start;

@end

NS_ASSUME_NONNULL_END

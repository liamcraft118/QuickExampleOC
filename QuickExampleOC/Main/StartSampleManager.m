//
//  StartSampleManager.m
//  QuickExampleOC
//
//  Created by Liam on 2021/3/4.
//

#import "StartSampleManager.h"
#import "LRUMutableDictionary.h"
#import "MemorySample.h"
#import "RunloopSample.h"

@implementation StartSampleManager

- (void)start {
//    [self startLRUDictTest];
    [self startMemoryTest];
//    [self startRunloopTest];
}

- (void)startLRUDictTest {
    LRUMutableDictionary *dict = [[LRUMutableDictionary alloc] init];
    NSArray *keys = @[@"1", @"2", @"3", @"3", @"2", @"1", @"4"];
    NSArray *values = @[@"1", @"2", @"3", @"3", @"2", @"1", @"4"];
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        NSString *value = values[i];
        [dict setObject:value forKey:key];
        NSLog(@"%@", dict);
    }
}

- (void)startMemoryTest {
    MemorySample *sample = [[MemorySample alloc] init];
    [sample start];
//    [sample performSelector:@selector(test)];
}

- (void)startRunloopTest {
    RunloopSample *sample = [[RunloopSample alloc] init];
    [sample start];
}

@end

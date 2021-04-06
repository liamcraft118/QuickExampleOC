//
//  LRUMutableDictionary.h
//  QuickExampleOC
//
//  Created by Liam on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRUMutableDictionary : NSObject

- (void)setObject:(nonnull id)anObject forKey:(nonnull id<NSCopying>)aKey;
- (id _Nullable)objectForKey:(nonnull id<NSCopying>)aKey;

@end

NS_ASSUME_NONNULL_END

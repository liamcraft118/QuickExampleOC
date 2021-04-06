//
//  LRUMutableDictionary.m
//  QuickExampleOC
//
//  Created by Liam on 2021/3/4.
//

#import "LRUMutableDictionary.h"

NSInteger const LRU_SIZE = 3;

@interface LRUMutableDictionary ()

@property (nonatomic, strong) NSMutableDictionary *cacheDict;
@property (nonatomic, strong) NSMutableArray<id<NSCopying>> *lruArray;
@property (nonatomic, assign) NSInteger lruSize;

@end


@implementation LRUMutableDictionary

- (instancetype)init {
    self = [super init];
    if (self) {
        _lruSize = LRU_SIZE;
        _cacheDict = [NSMutableDictionary dictionaryWithCapacity:LRU_SIZE + 1];
        _lruArray = [NSMutableArray arrayWithCapacity:LRU_SIZE + 1];
    }
    return self;
}


- (void)setObject:(nonnull id)anObject forKey:(nonnull id<NSCopying>)aKey {
    BOOL isExist = _cacheDict[aKey] != nil;
    
    // update lruArray
    // if exist
    if (isExist) {
        [_lruArray removeObject:aKey];
        [_lruArray insertObject:aKey atIndex:0];
    }
    // or not exist
    else {
        [_lruArray insertObject:aKey atIndex:0];
        if (_lruArray.count > LRU_SIZE) {
            id<NSCopying> lastElement = _lruArray.lastObject;
            _cacheDict[lastElement] = nil;
            [_lruArray removeLastObject];
        }
    }
    
    // update cache dict
    _cacheDict[aKey] = anObject;
}

- (id _Nullable)objectForKey:(nonnull id<NSCopying>)aKey {
    BOOL isExist = _cacheDict[aKey] != nil;
    
    // update lruArray
    if (isExist) {
        [_lruArray removeObject:aKey];
        [_lruArray insertObject:aKey atIndex:0];
    }

    return _cacheDict[aKey];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@\n%@", _lruArray, _cacheDict];
}

@end


@interface Node : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) Node *next;

- (void)insertAfter:(Node *)node;

@end

//
//  Person.h
//  QuickExampleOC
//
//  Created by Liam on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <NSCopying>

//@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *name;

//@property (nonatomic, unsafe_unretained) NSString *unsafe;
//@property (nonatomic, assign) NSString *unsafeAss;

@end

NS_ASSUME_NONNULL_END

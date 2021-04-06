//
//  ToolUtils.h
//  QuickExampleOC
//
//  Created by Liam on 2021/3/9.
//

#define LMLOG(object) NSLog(@"object = %@ !! pointer = %p !! content address = %p", object, &object, object);
#define LMLOG_INT(object) NSLog(@"object = %ld !! pointer = %p", object, &object);

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolUtils : NSObject

//+ (void)Log:(id)object;
//+ (void)LogInt:(NSInteger)integer;

@end

NS_ASSUME_NONNULL_END

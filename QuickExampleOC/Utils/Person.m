//
//  Person.m
//  QuickExampleOC
//
//  Created by Liam on 2021/4/6.
//

#import "Person.h"

@implementation Person

- (id)copyWithZone:(NSZone *)zone {
    Person *p = [Person allocWithZone:zone];
    p.name = _name;
    return p;
}

@end

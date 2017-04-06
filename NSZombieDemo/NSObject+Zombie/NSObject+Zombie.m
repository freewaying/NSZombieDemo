//
//  NSObject+Zombie.m
//  NSZombieDemo
//
//  Created by freewaying on 2017/3/30.
//  Copyright © 2017年 gmail.freewaying. All rights reserved.
//

#import "NSObject+Zombie.h"
#import <objc/runtime.h>
#import <string.h>
#import "_FRWZombie_.h"

@implementation NSObject (Zombie)

+ (void)load {
#if FRWZombieEnabed
    Method m1 = class_getInstanceMethod([self class], @selector(dealloc));
    Method m2 = class_getInstanceMethod([self class], @selector(zoombie_dealloc));
    method_exchangeImplementations(m1, m2);
#endif
}

- (void)zoombie_dealloc {
    const char *clsName = object_getClassName(self);
    const char *zombieClsNamePrefix = kZombieClsNamePrefix;
    const char *zombieClsName = [[NSString stringWithFormat:@"%s%s", zombieClsNamePrefix, clsName] cStringUsingEncoding:NSUTF8StringEncoding];
    Class zombieCls = objc_lookUpClass(zombieClsName);
    if (!zombieCls) {
        // Obtain the template zombie class called _NSZombie_
        const char *basicZombieClsName = kZombieClsNamePrefix;
        Class baseZombieCls = objc_lookUpClass(basicZombieClsName);
        zombieCls = objc_duplicateClass(baseZombieCls, zombieClsName, 0);
    }
    // Perform normal destruction of the object being deallocated
    objc_destructInstance(self);
    
    object_setClass(self, zombieCls);
}

@end

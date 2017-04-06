//
//  FRWZombieDemo.m
//  NSZombieDemo
//
//  Created by freewaying on 2017/3/30.
//  Copyright © 2017年 gmail.freewaying. All rights reserved.
//

#import "FRWZombieDemo.h"
#import <objc/runtime.h>
#import "NSObject+Zombie.h"

@implementation FRWZombieDemo

+ (void)printClassInfo:(id)obj {
    Class cls = object_getClass(obj);
    Class superCls = class_getSuperclass(cls);
    NSLog(@"===%s: %s===", class_getName(cls), class_getName(superCls));
}

/** demonstrate the existense NSZoombie class */
+ (void)demostrateZombie {
    FRWZombieDemo *obj = [[FRWZombieDemo alloc] init];
    NSLog(@"Before release:");
    [FRWZombieDemo printClassInfo:obj];
    [obj release];
    NSLog(@"After release:");
    [FRWZombieDemo printClassInfo:obj];
    
    NSLog(@"%@", [obj description]);
}

@end

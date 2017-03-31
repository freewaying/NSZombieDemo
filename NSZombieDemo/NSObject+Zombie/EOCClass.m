//
//  EOCClass.m
//  NSZombieDemo
//
//  Created by freewaying on 2017/3/30.
//  Copyright © 2017年 gmail.freewaying. All rights reserved.
//

#import "EOCClass.h"
#import <objc/runtime.h>
#import "NSObject+Zombie.h"

@implementation EOCClass

+ (void)printClassInfo:(id)obj {
    Class cls = object_getClass(obj);
    Class superCls = class_getSuperclass(cls);
    NSLog(@"===%s: %s===", class_getName(cls), class_getName(superCls));
}

/** demonstrate the existense NSZoombie class */
+ (void)demostrateZombie {
    EOCClass *obj = [[EOCClass alloc] init];
    NSLog(@"Before release:");
    [EOCClass printClassInfo:obj];
    [obj release];
    NSLog(@"After release:");
    [EOCClass printClassInfo:obj];
    
    NSLog(@"%@", [obj description]);
}

@end

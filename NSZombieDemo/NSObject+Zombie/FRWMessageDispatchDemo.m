//
//  FRWMessageDispatchDemo.m
//  NSZombieDemo
//
//  Created by freewaying on 2017/3/31.
//  Copyright © 2017年 gmail.freewaying. All rights reserved.
//

#import "FRWMessageDispatchDemo.h"
#import <objc/objc-class.h>

@implementation FRWMessageDispatchDemoHelper

- (void)method2 {
    NSLog(@"%@, %@: %p", self, NSStringFromSelector(_cmd), _cmd);
}

- (void)method3 {
    NSLog(@"%@, %@: %p", self, NSStringFromSelector(_cmd), _cmd);
}

@end

void functionForMethod1(id self, SEL _cmd) {
    NSLog(@"%@, %@: %p", self, NSStringFromSelector(_cmd), _cmd);
}

@interface FRWMessageDispatchDemo () {
    FRWMessageDispatchDemoHelper *_helper;
}

@end

@implementation FRWMessageDispatchDemo

- (instancetype)init {
    if (self = [super init]) {
        _helper = [[FRWMessageDispatchDemoHelper alloc] init];
    }
    return self;
}

- (void)test {
//    [self performSelector:@selector(method1)];
//    [self performSelector:@selector(method2)];
//    [self performSelector:@selector(method3)];
    [self performSelector:@selector(method4)];
}

#pragma mark step 1
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), NSStringFromSelector(sel));
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString isEqualToString:@"method1"]) {
        class_addMethod([self class], @selector(method1), (IMP)functionForMethod1, "@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

#pragma mark step 2
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), NSStringFromSelector(aSelector));
    NSString *selectorString = NSStringFromSelector(aSelector);
    if ([selectorString isEqualToString:@"method2"]) {
        return _helper;
    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark step 3
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), NSStringFromSelector(aSelector));
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        if ([FRWMessageDispatchDemoHelper instancesRespondToSelector:aSelector]) {
            methodSignature = [FRWMessageDispatchDemoHelper instanceMethodSignatureForSelector:aSelector];
        }
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), NSStringFromSelector(anInvocation.selector));
    if ([FRWMessageDispatchDemoHelper instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_helper];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), NSStringFromSelector(aSelector));
}

@end

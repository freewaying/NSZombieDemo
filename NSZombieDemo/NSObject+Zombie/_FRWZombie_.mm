//
//  _FRWZombie_.m
//  NSZombieDemo
//
//  Created by freewaying on 2017/3/31.
//  Copyright © 2017年 gmail.freewaying. All rights reserved.
//

#import "_FRWZombie_.h"
#import <objc/objc-class.h>

const char *kZombieClsNamePrefix = "_FRWZombie_";

/***********************************************************************
 * object_getMethodImplementation.
 **********************************************************************/
IMP object_getMethodImplementation(id obj, SEL name)
{
    Class cls = (obj ? object_getClass(obj) : nil);
    return class_getMethodImplementation(cls, name);
}

@implementation _FRWZombie_

+ (void)initialize {
}


+ (IMP)instanceMethodForSelector:(SEL)sel {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return class_getMethodImplementation(self, sel);
}

+ (IMP)methodForSelector:(SEL)sel {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return object_getMethodImplementation((id)self, sel);
}

- (IMP)methodForSelector:(SEL)sel {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return object_getMethodImplementation(self, sel);
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return NO;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

+ (void)doesNotRecognizeSelector:(SEL)sel {
    NSLog(@"+[%s %s]: unrecognized selector sent to instance %p",
                class_getName(self), sel_getName(sel), self);
}

- (void)doesNotRecognizeSelector:(SEL)sel {
    // check obj is kind of Zoombie object
    const char *clsName = object_getClassName(self);
    size_t n = strlen(kZombieClsNamePrefix);
    if (strncmp(clsName, kZombieClsNamePrefix, n) == 0) {
        // print class and message info about deallocated object
        const char *selName = sel_getName(sel);
        const char *originClsName = clsName + n;;
        NSLog(@"*** -[%s %s]: sent to deallocated instance %p", originClsName, selName, self);
        return;
    }
    
    NSLog(@"-[%s %s]: unrecognized selector sent to instance %p",
                object_getClassName(self), sel_getName(sel), self);
}
+ (id)performSelector:(SEL)sel {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return ((id(*)(id, SEL))objc_msgSend)((id)self, sel);
}

+ (id)performSelector:(SEL)sel withObject:(id)obj {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return ((id(*)(id, SEL, id))objc_msgSend)((id)self, sel, obj);
}

+ (id)performSelector:(SEL)sel withObject:(id)obj1 withObject:(id)obj2 {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return ((id(*)(id, SEL, id, id))objc_msgSend)((id)self, sel, obj1, obj2);
}

- (id)performSelector:(SEL)sel {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return ((id(*)(id, SEL))objc_msgSend)(self, sel);
}

- (id)performSelector:(SEL)sel withObject:(id)obj {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return ((id(*)(id, SEL, id))objc_msgSend)(self, sel, obj);
}

- (id)performSelector:(SEL)sel withObject:(id)obj1 withObject:(id)obj2 {
    if (!sel) [self doesNotRecognizeSelector:sel];
    return ((id(*)(id, SEL, id, id))objc_msgSend)(self, sel, obj1, obj2);
}

+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)sel {
    return nil;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return nil;
}

+ (void)forwardInvocation:(NSInvocation *)invocation {
    [self doesNotRecognizeSelector:(invocation ? [invocation selector] : 0)];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [self doesNotRecognizeSelector:(invocation ? [invocation selector] : 0)];
}

+ (id)forwardingTargetForSelector:(SEL)sel {
    return nil;
}

- (id)forwardingTargetForSelector:(SEL)sel {
    return nil;
}

@end

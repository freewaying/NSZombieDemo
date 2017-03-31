//
//  _FRWZombie_.h
//  NSZombieDemo
//
//  Created by freewaying on 2017/3/31.
//  Copyright © 2017年 gmail.freewaying. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const char *kZombieClsNamePrefix;

/** Zombie class to show info about deallocated object */
OBJC_ROOT_CLASS
@interface _FRWZombie_ {
    Class isa  OBJC_ISA_AVAILABILITY;
}

+ (void)initialize;

@end

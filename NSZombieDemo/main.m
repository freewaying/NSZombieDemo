//
//  main.m
//  NSZombieDemo
//
//  Created by freewaying on 2017/3/31.
//  Copyright © 2017年 gmail.freewaying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRWZombieDemo.h"
#import "FRWMessageDispatchDemo.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /* demonstrate the existense of NSZoombie class
         */
        [FRWZombieDemo demostrateZombie];
        
        /* demonstrate message-dispatch system
         FRWMessageDispatchDemo *md = [[FRWMessageDispatchDemo alloc] init];
         [md test];
         */
    }
    return 0;
}

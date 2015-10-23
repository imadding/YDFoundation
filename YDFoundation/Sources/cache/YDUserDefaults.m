//
//  YDUserDefaults.m
//  YDFoundation
//
//  Created by madding.lip on 5/4/15.
//  Copyright (c) 2015 yudao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDUserDefaults.h"

@implementation YDUserDefaults

YD_DEF_SINGLETON

- (BOOL)hasObjectForKey:(id)key {
  id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
  return value ? YES : NO;
}

- (id)objectForKey:(NSString *)key {
  if (nil == key) return nil;

  id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
  return value;
}

- (void)setObject:(id)value forKey:(NSString *)key {
  if (nil == key || nil == value) return;

  [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeObjectForKey:(NSString *)key {
  if (nil == key) return;

  [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeAllObjects {
  [NSUserDefaults resetStandardUserDefaults];
}

- (id)objectForKeyedSubscript:(id)key {
  return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id)key {
  if (obj) {
    [self setObject:obj forKey:key];
  } else {
    [self removeObjectForKey:key];
  }
}

@end

#import <objc/runtime.h>
#import "YDRTIvar.h"

/**
 * 通过Ivar 变量构造的子类
 */
@interface YDRTObjCIvar : YDRTIvar {
  Ivar _ivar;
}
@end

@implementation YDRTObjCIvar

- (id)initWithObjCIvar:(Ivar)ivar {
  if ((self = [self init])) {
    _ivar = ivar;
  }
  return self;
}

- (NSString *)name {
  return [NSString stringWithUTF8String:ivar_getName(_ivar)];
}

- (NSString *)typeEncoding {
  return [NSString stringWithUTF8String:ivar_getTypeEncoding(_ivar)];
}

- (ptrdiff_t)offset {
  return ivar_getOffset(_ivar);
}

@end

/**
 * 通过名称和类型构造的子类
 */
@interface YDRTComponentsIvar : YDRTIvar {
  NSString *_name;
  NSString *_typeEncoding;
}
@end

@implementation YDRTComponentsIvar

- (id)initWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding {
  if ((self = [self init])) {
    _name = [name copy];
    _typeEncoding = [typeEncoding copy];
  }
  return self;
}

- (NSString *)name {
  return _name;
}

- (NSString *)typeEncoding {
  return _typeEncoding;
}

- (ptrdiff_t)offset {
  return -1;
}

@end

@implementation YDRTIvar

+ (instancetype)ivarWithObjCIvar:(Ivar)ivar {
  return [[self alloc] initWithObjCIvar:ivar];
}

+ (instancetype)ivarWithName:(NSString *)name
                typeEncoding:(NSString *)typeEncoding {
  return [[self alloc] initWithName:name typeEncoding:typeEncoding];
}

+ (instancetype)ivarWithName:(NSString *)name encode:(const char *)encode {
  return [self ivarWithName:name
               typeEncoding:[NSString stringWithUTF8String:encode]];
}

- (instancetype)initWithObjCIvar:(Ivar)ivar {
  return [[YDRTObjCIvar alloc] initWithObjCIvar:ivar];
}

- (instancetype)initWithName:(NSString *)name
                typeEncoding:(NSString *)typeEncoding {
  return [[YDRTComponentsIvar alloc] initWithName:name
                                       typeEncoding:typeEncoding];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@ %p:%@ %@ %ld>", [self class], self,
                                    [self name], [self typeEncoding],
                                    (long)[self offset]];
}

- (BOOL)isEqual:(id)other {
  return [other isKindOfClass:[YDRTIvar class]] &&
         [[self name] isEqual:[other name]] &&
         [[self typeEncoding] isEqual:[other typeEncoding]];
}

- (NSUInteger)hash {
  return [[self name] hash] ^ [[self typeEncoding] hash];
}

- (NSString *)name {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (NSString *)typeEncoding {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (ptrdiff_t)offset {
  [self doesNotRecognizeSelector:_cmd];
  return 0;
}

@end

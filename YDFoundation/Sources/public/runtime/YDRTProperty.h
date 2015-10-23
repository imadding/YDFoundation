
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

typedef enum {
  YDRTPropertySetterSemanticsAssign,
  YDRTPropertySetterSemanticsRetain,
  YDRTPropertySetterSemanticsCopy
} YDRTPropertySetterSemantics;

/**
 * 属性封装类
 */
@interface YDRTProperty : NSObject

// 用objc_property_t实例构造方法一个YDRTProperty实例
+ (instancetype)propertyWithObjCProperty:(objc_property_t)property;

// 用属性名、各属性值构造方法一个YDRTProperty实例
+ (instancetype)propertyWithName:(NSString *)name
                      attributes:(NSDictionary *)attributes;

// 用objc_property_t实例构造方法一个YDRTProperty实例
- (instancetype)initWithObjCProperty:(objc_property_t)property;

// 用属性名、各属性值构造方法一个YDRTProperty实例
- (instancetype)initWithName:(NSString *)name
                  attributes:(NSDictionary *)attributes;

#if __MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_7
// 添加属性到classToAddTo类中
- (BOOL)addToClass:(Class)classToAddTo;
#endif

// 返回属性参数
- (NSDictionary *)attributes;

// 属性参数信息
- (NSString *)attributeEncodings;

// 返回属性设值方式
- (YDRTPropertySetterSemantics)setterSemantics;

// 返回属性是否是只读
- (BOOL)isReadOnly;

// 返回属性是否是非原子类型
- (BOOL)isNonAtomic;

// 返回属性是否是动态绑定类型
- (BOOL)isDynamic;

// 返回属性是否是弱引用
- (BOOL)isWeakReference;

//
- (BOOL)isEligibleForGarbageCollection;

// 返回自定义get方法选择器
- (SEL)customGetter;

// 返回自定义的set方法选择器
- (SEL)customSetter;

// 返回属性名
- (NSString *)name;

// 返回属性类型
- (NSString *)typeEncoding;

//
- (NSString *)oldTypeEncoding;

// 返回 属性绑定的变量名
- (NSString *)ivarName;

@end

// 类型编码
extern NSString *const kYDRTPropertyTypeEncodingAttribute;
// 属性返回类型
extern NSString *const kYDRTPropertyBackingIVarNameAttribute;

// copy
extern NSString *const kYDRTPropertyCopyAttribute;
// retain
extern NSString *const kYDRTPropertyRetainAttribute;
// getter
extern NSString *const kYDRTPropertyCustomGetterAttribute;
// setter
extern NSString *const kYDRTPropertyCustomSetterAttribute;
// dynamic
extern NSString *const kYDRTPropertyDynamicAttribute;
extern NSString *const kYDRTPropertyEligibleForGarbageCollectionAttribute;
// nonatomic
extern NSString *const kYDRTPropertyNonAtomicAttribute;
extern NSString *const kYDRTPropertyOldTypeEncodingAttribute;
// readonly
extern NSString *const kYDRTPropertyReadOnlyAttribute;
// weak
extern NSString *const kYDRTPropertyWeakReferenceAttribute;
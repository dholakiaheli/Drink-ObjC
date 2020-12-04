//
//  HBDrink.h
//  Drink-ObjC
//
//  Created by Heli Bavishi on 12/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBDrink : NSObject

@property (nonatomic, copy, readonly)NSString *drinkName;
@property (nonatomic, copy, readonly)NSString *drinkCategory;
@property (nonatomic, copy, readonly)NSString *drinkImage;

-(instancetype)initWithName:(NSString *)drinkName
                   category:(NSString *)drinkCategory
                      image:(NSString *)drinkImage;
@end

@interface HBDrink (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary;

@end

NS_ASSUME_NONNULL_END

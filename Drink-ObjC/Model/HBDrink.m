//
//  HBDrink.m
//  Drink-ObjC
//
//  Created by Heli Bavishi on 12/3/20.
//

#import "HBDrink.h"

static NSString * const drinkNameKey = @"strDrink";
static NSString * const drinkCategoryKey = @"strCategory";
static NSString * const drinkImageKey = @"strDrinkThumb";

@implementation HBDrink

- (instancetype)initWithName:(NSString *)drinkName category:(NSString *)drinkCategory image:(NSString *)drinkImage
{
    self = [super init];
    if (self)
    {
        _drinkName = drinkName;
        _drinkCategory = drinkCategory;
        _drinkImage = drinkImage;
        
        if ([_drinkImage isKindOfClass: [NSNull class]])
        {
            _drinkImage = nil;
        }
    }
    return self;
}
@end

@implementation HBDrink (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *name = dictionary[drinkNameKey];
    NSString *category = dictionary[drinkCategoryKey];
    NSString *image = dictionary[drinkImageKey];
    
    return [self initWithName:name category:category image:image];
}

@end

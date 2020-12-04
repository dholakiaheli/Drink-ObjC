//
//  HBDrinkController.h
//  Drink-ObjC
//
//  Created by Heli Bavishi on 12/3/20.
//

#import <Foundation/Foundation.h>
#import "HBDrink.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBDrinkController : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSArray<HBDrink *> *drinks;

- (void)fetchDrinkForSearchTerm:(NSString *)searchTerm completion: (void(^) (HBDrink *drink))completion;

- (void)fetchImageForDrink:(HBDrink *)drink completion: (void(^) (UIImage *))completion;

//- (void)fetchDrinkForSearchTerm:(NSString *)searchTerm completion: (void(^) (NSArray <HBDrink *> *drink))completion;

@end

NS_ASSUME_NONNULL_END

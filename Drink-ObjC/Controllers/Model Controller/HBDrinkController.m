//
//  HBDrinkController.m
//  Drink-ObjC
//
//  Created by Heli Bavishi on 12/3/20.
//

#import "HBDrinkController.h"

//static NSString * const baseURLString = @"https://www.thecocktaildb.com/api/json/v1/1/search.php?s=vodka";
static NSString * const baseURLString = @"https://www.thecocktaildb.com/api/json";
static NSString * const versionComponent = @"v1/1";
static NSString * const searchComponent = @"search";
static NSString * const phpExtension = @"php";
static NSString * const searchQueryKey = @"s";

@implementation HBDrinkController

+ (instancetype)sharedInstance
{
    static HBDrinkController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^ {
        sharedInstance = [HBDrinkController new];
    });
    return sharedInstance;
}

- (void)fetchDrinkForSearchTerm:(NSString *)searchTerm completion:(void (^)(HBDrink *))completion
{
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [url URLByAppendingPathComponent:versionComponent];
    NSURL *searchURL = [versionURL URLByAppendingPathComponent:searchComponent];
    NSURL *extensionURL = [searchURL URLByAppendingPathExtension:phpExtension];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:extensionURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:searchQueryKey value:searchTerm];
    urlComponents.queryItems = @[queryItem];
    
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@",finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
        
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
            return completion(nil);
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"No data was found");
            return completion(nil);
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelDictionary)
        {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil);
        }
        
        NSArray<NSDictionary *> *drinkDictionary = topLevelDictionary[@"drinks"];
        NSMutableArray *arrayOfDrinkNames = [NSMutableArray new];
        
        
        for (NSDictionary *dictionary in drinkDictionary)
        {
            HBDrink *drink = [[HBDrink alloc] initWithDictionary:dictionary];
            [arrayOfDrinkNames addObject:drink];
        }
        
        HBDrink *finalDrink = arrayOfDrinkNames.firstObject;
        HBDrinkController.sharedInstance.drinks = arrayOfDrinkNames;
        completion(finalDrink);
        
//        if (arrayOfDrinkNames.count != 0)
//        {
//            HBDrinkController.sharedInstance.drinks = arrayOfDrinkNames;
//            completion(arrayOfDrinkNames);
//        } else {
//            completion(nil);
//        }
    }]resume];
}

- (void)fetchImageForDrink:(HBDrink *)drink completion:(void (^)(UIImage *))completion
{
    if (drink.drinkImage)
    {
    NSURL *imageURL = [NSURL URLWithString:drink.drinkImage];
    NSLog(@"%@", imageURL);
    
    [[NSURLSession.sharedSession dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
        
        if (error)
        {
            NSLog(@"%@", error);
            return completion(nil);
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            return completion(nil);
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }] resume];
    }else
    {
        completion([UIImage imageNamed:@"CA"]);
    }
}

@end

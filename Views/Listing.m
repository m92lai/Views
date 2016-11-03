#import "Listing.h"

@implementation Listing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"ML_num",
             @"address": @"Address",
             @"price": @"Price"
             };
}

@end

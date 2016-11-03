#import "Neighbourhood.h"

@implementation Neighbourhood

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"CommunityName",
             @"code": @"CommunityCode"
             };
}

@end

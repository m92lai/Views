#import <Foundation/Foundation.h>

@interface FavouriteService : NSObject

+(void)saveFavouriteListingID:(NSString*)listingID;
+(NSArray*)loadFavouriteListingIDs;
@end

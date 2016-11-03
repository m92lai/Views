#import "FavouriteService.h"

@implementation FavouriteService

+(void)saveFavouriteListingID:(NSString*)listingID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray* array = [self loadFavouriteListingIDs];
    if (array == nil)
    {
        array = [[NSArray alloc] init];
    }
    if ( [array containsObject:listingID] )
    {
        return;
    }
    NSMutableArray *favourites = [NSMutableArray arrayWithArray:array];
    [favourites addObject:listingID];
    [prefs setObject:favourites forKey:@"favourites"];
}

+(NSArray*)loadFavouriteListingIDs
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs objectForKey:@"favourites"];
}

@end

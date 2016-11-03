#import <Foundation/Foundation.h>
#import "Neighbourhood.h"
#import "Listing.h"

@interface ViewsClient : NSObject

- (NSArray*)fetchNeighbourhoods;
- (NSArray*)fetchListings:(Neighbourhood *)neighbourhood;

@end

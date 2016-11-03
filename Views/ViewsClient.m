#import "ViewsClient.h"

@interface ViewsClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ViewsClient

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (id)post:(NSURL*)url withData:(NSData*)params
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:params];
    NSError *err;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    id json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&err];
    return json;
}

- (NSArray*)fetchNeighbourhoods
{
    NSString *urlString = @"http://schedulock.com/views/getNeighborhood";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *postString = @"CuToken=226b4907b2af7732bd6cf50199205627";
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *neighbourhoods = [NSMutableArray array];
    for (NSDictionary *neighbourhood in [self post:url withData:data])
    {
        [neighbourhoods addObject:[MTLJSONAdapter modelOfClass:[Neighbourhood class] fromJSONDictionary:neighbourhood error:nil]];
    }
    return [NSArray arrayWithArray:neighbourhoods];
}

- (NSArray*)fetchListings:(Neighbourhood *)neighbourhood
{
    NSString *urlString = @"http://schedulock.com/views/getListings";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *postString = [NSString stringWithFormat:@"CuToken=%@&CuName=%@", @"http://schedulock.com/views/getListings", neighbourhood.name];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *listings = [NSMutableArray array];
    for (NSDictionary *listing in [self post:url withData:data])
    {
        [listings addObject:[MTLJSONAdapter modelOfClass:[Listing class] fromJSONDictionary:listing error:nil]];
    }
    return [NSArray arrayWithArray:listings];
}

@end

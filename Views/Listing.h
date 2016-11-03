#import <Mantle/Mantle.h>

@interface Listing : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *price;

@end

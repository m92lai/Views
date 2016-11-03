#import <Mantle/Mantle.h>

@interface Neighbourhood : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;

@end

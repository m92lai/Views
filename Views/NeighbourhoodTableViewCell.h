#import <UIKit/UIKit.h>
#import "Neighbourhood.h"

@interface NeighbourhoodTableViewCell : UITableViewCell

@property (strong, nonatomic) Neighbourhood *neighbourhood;
@property (strong, nonatomic) UILabel *name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withWidth:(CGFloat)width andHeight:(CGFloat)height andNeighbourhood:(Neighbourhood *)neighbourhood;


@end

#import "NeighbourhoodTableViewCell.h"

@implementation NeighbourhoodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withWidth:(CGFloat)width andHeight:(CGFloat)height andNeighbourhood:(Neighbourhood *)neighbourhood
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.neighbourhood = neighbourhood;
        [self setFrame:CGRectMake(0, 0, width, height)];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame) - (self.bounds.size.width / 2.0),
                                                              CGRectGetMidY(self.frame) - (self.bounds.size.height / 2.0),
                                                              self.bounds.size.width,
                                                              self.bounds.size.height)];
        self.name.textColor = [UIColor whiteColor];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.font = [UIFont boldSystemFontOfSize:16];
        self.name.text = neighbourhood.name;
        [self addSubview:self.name];
    }
    return self;
}

@end

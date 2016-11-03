#import <UIKit/UIKit.h>
#import "Neighbourhood.h"

@interface NeighbourhoodViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageVC;

- (id)initWithNeighbourhood:(Neighbourhood *)neighourhood;

@end

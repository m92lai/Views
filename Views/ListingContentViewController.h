#import <UIKit/UIKit.h>

@interface ListingContentViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSMutableArray *views;
@property (strong, nonatomic) UIView *currentView;

@end

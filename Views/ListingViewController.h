#import <UIKit/UIKit.h>
#import "ListingContentViewController.h"
#import "Listing.h"

@interface ListingViewController : UIViewController<UIGestureRecognizerDelegate> {
    UIPanGestureRecognizer *panGesture;
    CGPoint firstPoint;
    BOOL detailsToggle;
}

@property (strong, nonatomic) Listing *listing;

@property (strong, nonatomic) UIPageViewController *pageVC;
@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) ListingContentViewController *contentVC;
@property (strong, nonatomic) UIView *detailsBottomView;
@property (strong, nonatomic) UIView *detailsTopView;
@property (strong, nonatomic) UIButton *up;
@property (strong, nonatomic) UIButton *favourite;

- (id)initWithListing:(Listing *)listing;

@end

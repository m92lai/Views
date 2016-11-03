#import "NeighbourhoodViewController.h"
#import "ListingViewController.h"
#import "ViewsClient.h"

@interface NeighbourhoodViewController ()

@property (nonatomic, strong) ViewsClient *client;
@property (nonatomic, strong) NSArray *listings;

@end

@implementation NeighbourhoodViewController

- (id)initWithNeighbourhood:(Neighbourhood *)neighourhood
{
    if (self = [super init]) {
        _client = [[ViewsClient alloc] init];
        _listings = [_client fetchListings:neighourhood];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO; 
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.dataSource = self;
    self.pageVC.view.frame = self.view.bounds;
    
    ListingViewController *initialVC = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
    
    [self.pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    [self.pageVC didMoveToParentViewController:self];
}

- (ListingViewController *)viewControllerAtIndex:(NSUInteger)index
{
    ListingViewController *listingVC = [[ListingViewController alloc] initWithListing:[_listings objectAtIndex:index]];
    listingVC.index = index;
    return listingVC;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [(ListingViewController *)viewController index];
    if (index == 0)
    {
        return nil;
    }
    return [self viewControllerAtIndex:index-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ListingViewController *)viewController index];
    if (index == ([_listings count] - 1))
    {
        return nil;
    }
    return [self viewControllerAtIndex:index+1];
}

@end

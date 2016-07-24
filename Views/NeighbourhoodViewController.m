#import "NeighbourhoodViewController.h"
#import "ListingViewController.h"

@interface NeighbourhoodViewController ()

@end

@implementation NeighbourhoodViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    
    ListingViewController *listingVC = [[ListingViewController alloc] init];
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
    if (index == 5)
    {
        return nil;
    }
    return [self viewControllerAtIndex:index+1];
}

@end

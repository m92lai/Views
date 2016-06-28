//
//  ListingsController.m
//  
//
//  Created by Michael Lai on 6/27/16.
//
//

#import "ListingViewController.h"

@interface ListingViewController ()

@end

@implementation ListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentVC = [[ListingContentViewController alloc] init];
    self.detailsVC = [[ListingDetailsViewController alloc] init];
    NSArray *viewControllers = [NSArray arrayWithObject:self.contentVC];
    
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    self.pageVC.dataSource = self;
    [[self.pageVC view] setFrame:[self.view bounds]];
    
    [self.pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    [self.pageVC didMoveToParentViewController:self];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if([viewController isKindOfClass:[ListingContentViewController class]])
    {
        return nil;
    }
    return self.contentVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if([viewController isKindOfClass:[ListingDetailsViewController class]])
    {
        return nil;
    }
    return self.detailsVC;
}

@end

//
//  ListingsController.h
//  
//
//  Created by Michael Lai on 6/27/16.
//
//

#import <UIKit/UIKit.h>
#import "ListingContentViewController.h"
#import "ListingDetailsViewController.h"

@interface ListingViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageVC;
@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) ListingContentViewController *contentVC;
@property (strong, nonatomic) ListingDetailsViewController *detailsVC;

@end

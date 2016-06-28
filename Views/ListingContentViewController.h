//
//  ContentViewController.h
//  
//
//  Created by Michael Lai on 6/27/16.
//
//

#import <UIKit/UIKit.h>

@interface ListingContentViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSMutableArray *views;
@property (strong, nonatomic) UIView *currentView;

@end

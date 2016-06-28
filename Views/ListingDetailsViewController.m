//
//  ListingDetailsViewController.m
//  
//
//  Created by Michael Lai on 6/27/16.
//
//

#import "ListingDetailsViewController.h"

@interface ListingDetailsViewController ()

@end

@implementation ListingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.center = self.view.center;
    label.text = @"Details";
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
}

@end

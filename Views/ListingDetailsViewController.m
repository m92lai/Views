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

- (id)initWithListingIndex:(NSInteger)listingIndex
{
    if( (self = [super init]) )
    {
        self.listingIndex = listingIndex;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.center = self.view.center;
    label.text = [NSString stringWithFormat:@"Details %ld", _listingIndex + 1];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
}

@end

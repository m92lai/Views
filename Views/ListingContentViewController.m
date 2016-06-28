//
//  ContentViewController.m
//  
//
//  Created by Michael Lai on 6/27/16.
//
//

#import "ListingContentViewController.h"

@interface ListingContentViewController ()

@end

@implementation ListingContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.views = [[NSMutableArray alloc] init];
    
    for ( int i = 0; i < 5; i++ )
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        label.center = self.view.center;
        label.text = [NSString stringWithFormat:@"Content %c", i + 65];
        label.textAlignment = NSTextAlignmentCenter;
        [self.views addObject:label];
        
        if ( i == 0 )
        {
            self.currentView = label;
            [self.view addSubview:label];
        }
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.currentView removeFromSuperview];
        _index = (_index + 1) % 5;
        self.currentView = [self.views objectAtIndex:_index];
        [self.view addSubview:self.currentView];
    }
}

@end

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.views = [[NSMutableArray alloc] init];
    
    NSArray *imageURLs = [NSArray arrayWithObjects:
                          @"http://theiphonewalls.com/wp-content/uploads/2015/05/Toronto-Skyline.jpg",
                          @"https://wallpaperscraft.com/image/toronto_canada_night_city_lights_light_693_640x1136.jpg",
                          @"http://www.ilikewallpaper.net/iphone-6-wallpapers/download/27523/Toronto-Lake-Canada-City-Night-View-iphone-6-wallpaper-ilikewallpaper_com.jpg",
                          @"https://wallpaperscraft.com/image/city_toronto_canada_sky_clouds_houses_58869_750x1334.jpg",
                          nil];
    
    for ( NSString *url in imageURLs )
    {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
                image.frame = self.view.frame;
                [self.views addObject:image];
                
                @synchronized(self) {
                    if ( ! self.currentView )
                    {
                        self.currentView = image;
                        [self.view addSubview:image];
                    }
                }
            });
        });
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.currentView removeFromSuperview];
        _index = (_index + 1) % [self.views count];
        self.currentView = [self.views objectAtIndex:_index];
        [self.view addSubview:self.currentView];
    }
}

@end

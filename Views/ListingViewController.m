#import "ListingViewController.h"
#import "FavouriteService.h"

@interface ListingViewController ()

@end

@implementation ListingViewController

- (id)initWithListing:(Listing *)listing
{
    if (self = [super init]) {
        self.listing = listing;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    detailsToggle = NO;
    
    self.contentVC = [[ListingContentViewController alloc] init];
    CGFloat detailsBottomHeight = self.view.bounds.size.height * 0.5;
    self.detailsBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 30, self.view.bounds.size.width, detailsBottomHeight)];
    self.detailsBottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    CGFloat detailsTopHeight = self.view.bounds.size.height * 0.15;
    self.detailsTopView = [[UIView alloc] initWithFrame:CGRectMake(0, -detailsTopHeight, self.view.bounds.size.width, detailsTopHeight)];
    self.detailsTopView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.detailsTopView.frame.size.width, self.detailsTopView.frame.size.height)];
    test.textColor = [UIColor whiteColor];
    test.text = self.listing.address;
    
    
    self.up = [[UIButton alloc] initWithFrame:CGRectMake(self.detailsBottomView.center.x - 10, 5, 20, 20)];
    UIImage *burger = [UIImage imageNamed:@"burger.png"];
    [self.up setImage:burger forState:UIControlStateNormal];
    self.up.userInteractionEnabled = YES;
    UITapGestureRecognizer *upTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleUpTap:)];
    [self.up addGestureRecognizer:upTap];

    self.favourite = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 50)];
    UIImage *heart = [UIImage imageNamed:@"heart.png"];
    [self.favourite setImage:heart forState:UIControlStateNormal];
    self.favourite.userInteractionEnabled = YES;
    UITapGestureRecognizer *heartTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFavouriteTap:)];
    [self.favourite addGestureRecognizer:heartTap];
    
    [self.detailsTopView addSubview:test];
    [self.detailsBottomView addSubview:self.up];
    [self.detailsBottomView addSubview:self.favourite];

    [self.view addSubview:self.contentVC.view];
    [self.view addSubview:self.detailsBottomView];
    [self.view addSubview:self.detailsTopView];

    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDetails:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}

- (void)handleUpTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self animationShow];
    }
}

- (void)handleFavouriteTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [FavouriteService saveFavouriteListingID:self.listing.id];
    }
}

- (BOOL)isMovable:(CGFloat)distance
{
    CGFloat newLocationY = self.detailsBottomView.frame.origin.y + distance;
    CGFloat containerHeight = self.view.bounds.size.height;
    CGFloat viewHeight = self.detailsBottomView.bounds.size.height;
    return (newLocationY >= containerHeight - viewHeight) && (newLocationY <= containerHeight - 30);
}

- (CGFloat)percentageMoved
{
    return (self.view.bounds.size.height - self.detailsBottomView.frame.origin.y) / self.detailsBottomView.bounds.size.height;
}

- (void)moveDetails:(UIPanGestureRecognizer *)sender
{
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        firstPoint = [sender locationInView:self.view];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint secondPoint = [sender locationInView:self.view];
        CGFloat distance = secondPoint.y - firstPoint.y;
        if ([self isMovable:distance])
        {
            self.detailsBottomView.center = CGPointMake(self.detailsBottomView.center.x, self.detailsBottomView.center.y + distance);
            CGFloat ratio = self.detailsTopView.bounds.size.height / (self.detailsBottomView.bounds.size.height - 50);
            self.detailsTopView.center = CGPointMake(self.detailsTopView.center.x, self.detailsTopView.center.y - (distance * ratio));
            
            CGFloat p = [self percentageMoved];
            self.detailsBottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:p * 0.5];
            self.detailsTopView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:p * 0.5];
        }
        firstPoint = secondPoint;
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        if ([self percentageMoved] >= 0.5 || fabs([sender velocityInView:self.view].y) > 10)
        {
            [self animationShow];
        }
    }
}

- (void)animationShow
{
    [UIView transitionWithView:self.view
                      duration:0.2
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        if (detailsToggle) {
                            [self.detailsTopView setFrame:CGRectMake(0, -self.detailsTopView.bounds.size.height, self.detailsTopView.bounds.size.width, self.detailsTopView.bounds.size.height)];
                            self.detailsTopView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                            [self.detailsBottomView setFrame:CGRectMake(0, self.view.bounds.size.height - 30, self.detailsBottomView.bounds.size.width, self.detailsBottomView.bounds.size.height)];
                            self.detailsBottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                        }
                        else {
                            [self.detailsTopView setFrame:CGRectMake(0, 0, self.detailsTopView.bounds.size.width, self.detailsTopView.bounds.size.height)];
                            self.detailsTopView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
                            [self.detailsBottomView setFrame:CGRectMake(0, self.view.bounds.size.height - self.detailsBottomView.bounds.size.height, self.detailsBottomView.bounds.size.width, self.detailsBottomView.bounds.size.height)];
                            self.detailsBottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
                        }
                    }
                    completion:nil];
    detailsToggle = !detailsToggle;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)sender
{
    if (sender == panGesture) {
        CGPoint velocity = [panGesture velocityInView:self.view];
        return fabs(velocity.y) > 2 * fabs(velocity.x);
    } else {
        return YES;
    }
}

@end

#import "NeighbourhoodSelectionViewController.h"
#import "NeighbourhoodTableViewCell.h"
#import "NeighbourhoodViewController.h"
#import "ViewsClient.h"
#import "Neighbourhood.h"

@interface NeighbourhoodSelectionViewController ()

@property (nonatomic, strong) ViewsClient *client;
@property (nonatomic, strong) NSArray *neighbourhoods;

@end

@implementation NeighbourhoodSelectionViewController

- (id)init {
    if (self = [super init]) {
        _client = [[ViewsClient alloc] init];
        _neighbourhoods = [_client fetchNeighbourhoods];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    imageURLs = [NSArray arrayWithObjects:
                          @"http://theiphonewalls.com/wp-content/uploads/2015/05/Toronto-Skyline.jpg",
                          @"https://wallpaperscraft.com/image/toronto_canada_night_city_lights_light_693_640x1136.jpg",
                          @"http://www.ilikewallpaper.net/iphone-6-wallpapers/download/27523/Toronto-Lake-Canada-City-Night-View-iphone-6-wallpaper-ilikewallpaper_com.jpg",
                          @"https://wallpaperscraft.com/image/city_toronto_canada_sky_clouds_houses_58869_750x1334.jpg",
                          nil];

    self.neighboursTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.neighboursTableView.delegate = self;
    self.neighboursTableView.dataSource = self;
    
    [self.view addSubview:self.neighboursTableView];
}

#pragma mark - UITableView neighboursTableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_neighbourhoods count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    
    NeighbourhoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[NeighbourhoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withWidth:self.view.bounds.size.width andHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath] andNeighbourhood:[_neighbourhoods objectAtIndex:indexPath.row]];
    }
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[imageURLs objectAtIndex:(indexPath.row % imageURLs.count)]]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
            
            @synchronized(self) {
                cell.backgroundView = imageView;
            }
        });
    });

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NeighbourhoodViewController *neighbourhoodVC = [[NeighbourhoodViewController alloc] initWithNeighbourhood:[_neighbourhoods objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:neighbourhoodVC animated:YES];
}
@end

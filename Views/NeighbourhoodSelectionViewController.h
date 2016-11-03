#import <UIKit/UIKit.h>

@interface NeighbourhoodSelectionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    NSArray *imageURLs;
}

@property (strong, nonatomic) UITableView *neighboursTableView;

@end

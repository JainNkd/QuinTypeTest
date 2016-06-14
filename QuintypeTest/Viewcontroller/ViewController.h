//
//  ViewController.h
//  QuintypeTest
//
//  Created by Naveen on 13/06/16.
//  Copyright © 2016 Naveen Kumar Dungarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *searchMoviesList;
}
@property (weak, nonatomic) IBOutlet UITableView *movieTableView;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end


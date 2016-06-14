//
//  MovieTableViewCell.h
//  QuintypeTest
//
//  Created by Naveen on 13/06/16.
//  Copyright © 2016 Naveen Kumar Dungarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieCovorImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

//
//  MovieDetailViewController.h
//  QuintypeTest
//
//  Created by Naveen on 13/06/16.
//  Copyright © 2016 Naveen Kumar Dungarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h";

@interface MovieDetailViewController : UIViewController<UIGestureRecognizerDelegate>

@property(nonatomic,strong)Movie *movieDetail;

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;

@property (weak, nonatomic) IBOutlet UILabel *writerLabel;

@property (weak, nonatomic) IBOutlet UILabel *actorsLabel;

@property (weak, nonatomic) IBOutlet UILabel *plotDetailLabel;
@end

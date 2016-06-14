//
//  MovieDetailViewController.m
//  QuintypeTest
//
//  Created by Naveen on 13/06/16.
//  Copyright © 2016 Naveen Kumar Dungarwal. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

@interface MovieDetailViewController ()
{
    UIImageView *imageView;
}
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set all values to View
    [self setAllDetailValues];
}

-(void)setAllDetailValues
{
    self.posterImage.userInteractionEnabled = YES;
    UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(showPosterAsFullScreen:)];
    tgr.numberOfTapsRequired = 1;
    [self.posterImage addGestureRecognizer: tgr];
    
    
    self.title = self.movieDetail.title;
    self.titleLabel.text = self.movieDetail.title;
    self.releaseDateLabel.text = [NSString stringWithFormat:@"Release Date: %@",self.movieDetail.released];
    self.countryLabel.text = self.movieDetail.country;
    if(![self.movieDetail.imdbRating isEqualToString:@"N/A"])
        self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %@/10.0",self.movieDetail.imdbRating];
    else
        self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %@",self.movieDetail.imdbRating];
    
    
    self.directorLabel.text = [NSString stringWithFormat:@"Director: %@", self.movieDetail.director];
    [self.directorLabel sizeToFit];
    
    self.writerLabel.text = [NSString stringWithFormat:@"Writer: %@", self.movieDetail.writer];
    [self.writerLabel sizeToFit];
    
    self.actorsLabel.text = [NSString stringWithFormat:@"Actors: %@", self.movieDetail.actors];
    [self.actorsLabel sizeToFit];
    
    self.plotDetailLabel.text = [NSString stringWithFormat:@"Plot: %@", self.movieDetail.plot];
    [self.plotDetailLabel sizeToFit];
    
    
    @try {
        if(self.movieDetail.poster.length>0){
            NSURL* url = [NSURL URLWithString:self.movieDetail.poster];
            
            [self.posterImage sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if(image){
                    //                        CGFloat th=(SCREEN_WIDTH*image.size.height)/image.size.width;
                    //                        [self.feedImageView invalidateIntrinsicContentSize];
                    //                        [self.imageHContraint setConstant:th];
                    self.posterImage.image =image;
                    
                }
                else{
                    self.posterImage.image = [UIImage imageNamed:@""];
                }
            }];
        }
        else{
            self.posterImage.image = [UIImage imageNamed:@""];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception");
    }
    
}

// Tap gesture to show image in full screen

-(void)showPosterAsFullScreen : (UITapGestureRecognizer*) sender
{
    UIImageView * iv = self.posterImage;
    
    imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.image = iv.image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = [self.view convertRect: iv.frame fromView: iv.superview];
    imageView.userInteractionEnabled = YES;
    imageView.clipsToBounds = YES;
    
    objc_setAssociatedObject( imageView,
                             "original_frame",
                             [NSValue valueWithCGRect: imageView.frame],
                             OBJC_ASSOCIATION_RETAIN);
    
    [UIView transitionWithView: self.view
                      duration: 0.5
                       options: UIViewAnimationOptionAllowAnimatedContent
                    animations:^{
                        [self.view addSubview: imageView];
                        imageView.frame = self.view.bounds;
                        self.navigationController.navigationBarHidden = YES;
                        
                    } completion:^(BOOL finished) {
                        UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( onTap: )];
                        [imageView addGestureRecognizer: tgr];
                        
                    }];
}

- (void) onTap: (UITapGestureRecognizer*) sender
{
    [UIView animateWithDuration: 0.5
                     animations:^{
                         sender.view.frame = [objc_getAssociatedObject( sender.view,
                                                                       "original_frame" ) CGRectValue];
                         self.navigationController.navigationBarHidden = NO;
                     } completion:^(BOOL finished) {
                         
                         [sender.view removeFromSuperview];
                     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

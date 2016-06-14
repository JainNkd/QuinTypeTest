//
//  ViewController.m
//  QuintypeTest
//
//  Created by Naveen on 13/06/16.
//  Copyright © 2016 Naveen Kumar Dungarwal. All rights reserved.
//

#import "ViewController.h"
#import "MovieTableViewCell.h"
#import "Movie.h"
#import "QuinTypeUtill.h"
#import "UIImageView+WebCache.h"
#import "MovieDetailViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Search Movies";
    searchMoviesList = [[NSMutableArray alloc]init];
    
    [self showSearchResultLabel:NO];
}

#pragma Search Delegates all methods implementations

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"Search text...%@",searchText);
    if(searchText.length>1)
        [self searchMoviesByTitle:searchText];
    else{
        [searchMoviesList removeAllObjects];
        [self.movieTableView reloadData];
        [self showSearchResultLabel:NO];
    }
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchbar cancel buttton clicked");
    [searchMoviesList removeAllObjects];
    [self.movieTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchbar search buttton clicked");
}

#pragma TabelView Delegate all Methods Implementations

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchMoviesList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MovieTableViewCell";
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Movie *movieObj = [searchMoviesList objectAtIndex:indexPath.row];
    cell.titleLabel.text = movieObj.title;
    
    @try {
        if(movieObj.poster.length>0){
            NSURL* url = [NSURL URLWithString:movieObj.poster];
            
            [cell.movieCovorImage sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if(image){
                    cell.movieCovorImage.image =image;
                    [cell.contentView layoutIfNeeded];
                    
                }
                else{
                    cell.movieCovorImage.image = [UIImage imageNamed:@""];
                }
            }];
        }
        else{
            cell.movieCovorImage.image = [UIImage imageNamed:@""];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception");
    }
    
    
    return cell;
}

//Search Movies by title
-(void)searchMoviesByTitle:(NSString*)searchString
{
    
    NSString *searchUrl = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@&r=json",searchString];
    searchUrl =  [searchUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:searchUrl]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    // Create url connection and fire request
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroundQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               dispatch_async(dispatch_get_main_queue()
                                              , ^(void) {
                                                     [self showSearchResultLabel:YES];
                                              });
                               if (error)
                               {
                                   NSLog(@"error%@",[error localizedDescription]);
                               }
                               else
                               {
                                   
                                   NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"result....%@",result);
                                   
                                   NSError *jsonParsingError = nil;
                                   id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
                                   
                                   if (jsonParsingError) {
                                       NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
                                   } else {
                                       NSDictionary *responseDict = (NSDictionary*)object;
                                       Movie *movieObj = [[Movie alloc]movieInitWithDict:responseDict];
                                       
                                       if([movieObj.response isEqualToString:@"True"])
                                       {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               
                                               [self showSearchResultLabel:NO];
                                               [searchMoviesList removeAllObjects];
                                               [searchMoviesList addObject:movieObj];
                                               [self.movieTableView reloadData];
                                           });
                                           
                                       }
                                       else
                                       {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                   [self showSearchResultLabel:YES];
                                           });
                                           
                                           //                                           NSString*erroMsg = movieObj.error;
                                           //
                                       }
                                   }
                                   
                               }
                           }];
}

//Show and Hide search result label
-(void)showSearchResultLabel:(BOOL)isShow
{
    self.resultLabel.hidden = !isShow;
    self.movieTableView.hidden = isShow;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(searchMoviesList.count> indexPath.row ){
        MovieDetailViewController *movieDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetailViewController"];
        movieDetailVC.movieDetail = [searchMoviesList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:movieDetailVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  Movie.h
//  QuintypeTest
//
//  Created by Naveen on 13/06/16.
//  Copyright © 2016 Naveen Kumar Dungarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property(nonatomic,strong) NSString *title,*year,*rated,*released,*runtime,*genre,*director,*writer,*actors,*language,*country,*awards,*poster,*imdbRating,*imdbVotes,*imdbID,*type,*response,*error;

-(Movie*)movieInitWithDict:(NSDictionary*)dataDict;
@end

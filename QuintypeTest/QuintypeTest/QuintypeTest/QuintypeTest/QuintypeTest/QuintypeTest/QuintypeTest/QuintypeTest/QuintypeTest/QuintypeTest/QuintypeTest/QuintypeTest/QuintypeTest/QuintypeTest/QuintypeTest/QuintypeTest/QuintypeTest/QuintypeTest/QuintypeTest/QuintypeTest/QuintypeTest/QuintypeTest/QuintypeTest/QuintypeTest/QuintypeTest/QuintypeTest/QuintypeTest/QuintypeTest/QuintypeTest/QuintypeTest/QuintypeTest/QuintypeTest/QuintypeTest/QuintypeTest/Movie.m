//
//  Movie.m
//  QuintypeTest
//
//  Created by Naveen on 13/06/16.
//  Copyright © 2016 Naveen Kumar Dungarwal. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(Movie*)movieInitWithDict:(NSDictionary*)dataDict
{
    if(self == [super self])
    {
        self.title = [dataDict valueForKey:@"Title"];
                self.title = [dataDict valueForKey:@"Title"];
                self.poster = [dataDict valueForKey:@"Poster"];
                self.year = [dataDict valueForKey:@"Year"];
                self.rated = [dataDict valueForKey:@"Rated"];
                self.released = [dataDict valueForKey:@"Released"];
                self.runtime = [dataDict valueForKey:@"Runtime"];
                self.genre = [dataDict valueForKey:@"Genre"];
                self.director = [dataDict valueForKey:@"Director"];
                self.writer = [dataDict valueForKey:@"Writer"];
        
                self.actors = [dataDict valueForKey:@"Actors"];
                self.language = [dataDict valueForKey:@"Language"];
                self.country = [dataDict valueForKey:@"Country"];
                self.awards = [dataDict valueForKey:@"Awards"];
                self.imdbRating = [dataDict valueForKey:@"imdbRating"];
                self.imdbVotes = [dataDict valueForKey:@"imdbVotes"];
                self.imdbID = [dataDict valueForKey:@"imdbID"];
                self.type = [dataDict valueForKey:@"Type"];
                self.response = [dataDict valueForKey:@"Response"];
                self.error = [dataDict valueForKey:@"Error"];
        
    }
    return self;
}
@end

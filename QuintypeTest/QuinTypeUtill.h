//
//  QuinTypeUtill.h
//  QuintypeTest
//
//  Created by Naveen on 14/06/16.
//  Copyright © 2016 Naveen Kumar Dungarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuinTypeUtill : NSObject

// Alert 
+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherTitle delegate:(id)sender tag:(NSInteger)alertTag;

// Check of null values
+(id)nullValue:(id)val;
@end

//
//  GnomeTableViewCell.m
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import "GnomeTableViewCell.h"

@implementation GnomeTableViewCell

+ (UIColor *)colorForGender:(NSString*)hairColor {
    
    NSString *colorLowercase = [hairColor lowercaseString];
    
    if ([colorLowercase isEqualToString:@"pink"]) {
        return [UIColor colorWithRed:0.74 green:0.41 blue:0.53 alpha:1.0];;
    } else {
        return [UIColor colorWithRed:0.41 green:0.52 blue:0.74 alpha:1.0];;
    }
}

@end

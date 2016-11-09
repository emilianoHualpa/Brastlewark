//
//  GnomeTableViewCell.m
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import "GnomeTableViewCell.h"

@implementation GnomeTableViewCell

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.2;  //  0.2 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.2;  //  0.2 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end

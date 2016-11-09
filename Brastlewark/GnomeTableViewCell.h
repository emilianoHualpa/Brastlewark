//
//  GnomeTableViewCell.h
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GnomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellMainLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDetailLabel;

+ (UIColor *)randomColor;

@end

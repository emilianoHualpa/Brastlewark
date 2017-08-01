//
//  GnomeDetailViewController.h
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gnome.h"

@interface GnomeDetailViewController : UIViewController

@property (strong, nonatomic) Gnome *gnome;
@property (strong, nonatomic) UIColor *backgroundColor;

#pragma mark Static Labels
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *hairColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *proffessionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendsLabel;

#pragma mark Dynamic Labels
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *hairColorValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *proffesionsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendsValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImg;

@end

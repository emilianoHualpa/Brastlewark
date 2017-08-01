//
//  GnomeDetailViewController.m
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import "GnomeDetailViewController.h"
#import "RestManager.h"

@interface GnomeDetailViewController ()

@end

@implementation GnomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleNavBar];
    [self populateData];
}

-(void)styleNavBar {
    self.view.backgroundColor = self.backgroundColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor darkGrayColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)populateData {
    self.nameLabel.text = self.gnome.name;
    self.ageValueLabel.text = [NSString stringWithFormat:@"%li", (long)self.gnome.age];
    self.weightValueLabel.text = [NSString stringWithFormat:@"%.2f", self.gnome.weight];
    self.heightValueLabel.text = [NSString stringWithFormat:@"%.2f", self.gnome.height];
    self.hairColorValueLabel.text = self.gnome.hairColor;
    self.proffesionsValueLabel.text = self.gnome.professionsString;
    self.friendsValueLabel.text = self.gnome.friendsString;
   
    [[RestManager sharedManager] getImageForGnome:self.thumbnailImg fromURL:self.gnome.thumbnailURL];
}

@end

//
//  GnomeDetailViewController.m
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import "GnomeDetailViewController.h"
#import <UIImageView+AFNetworking.h>

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
    self.proffesionsValueLabel.numberOfLines = 0;
    self.friendsValueLabel.numberOfLines = 0;
    
    self.nameLabel.text = self.gnome.name;
    self.ageValueLabel.text = [NSString stringWithFormat:@"%li", (long)self.gnome.age];
    self.weightValueLabel.text = [NSString stringWithFormat:@"%.2f", self.gnome.weight];
    self.heightValueLabel.text = [NSString stringWithFormat:@"%.2f", self.gnome.height];
    self.hairColorValueLabel.text = self.gnome.hairColor;
    self.proffesionsValueLabel.text = [self concatenateStringsInArray: self.gnome.professions withEmptyMessage:@"No professions found."];
    self.friendsValueLabel.text = [self concatenateStringsInArray: self.gnome.friends withEmptyMessage:@"Apparently I don't have any friends. 😢"];
    
    // Download images asynchronously
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:self.gnome.thumbnailURL
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [self.thumbnailImg setImageWithURLRequest:imageRequest placeholderImage:[UIImage imageNamed:@"placeholder"] success:nil failure:nil];
}

-(NSString*)concatenateStringsInArray:(NSArray*)array withEmptyMessage:(NSString*)emptyMessage{
    
    if (array.count != 0){
        // Concatenate professions into String
        NSMutableString *stringConcatenated = (NSMutableString*)[array componentsJoinedByString:@", "];
        [stringConcatenated appendString:@"."];
        return stringConcatenated;
    } else {
        return emptyMessage;
    }
}

@end

//
//  GnomeTableViewController.h
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GnomeTableViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) NSArray *gnomesDataSource;

@end

//
//  HomeViewController.m
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import "HomeViewController.h"
#import "GnomeTableViewController.h"
#import "Gnome.h"
#import "RestManager.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *tryAgainButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSMutableArray* gnomesDataSource;

@end

@implementation HomeViewController

static NSString * const kSegue = @"showGnomeTable";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.013 green:0.233 blue:0.227 alpha:1.00];
    [self.tryAgainButton setHidden:YES];
    [self.spinner setHidesWhenStopped:YES];
    self.gnomesDataSource = NSMutableArray.new;
    [self getGnomes:Brastlewark];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kSegue]) {
        GnomeTableViewController *gtvc = segue.destinationViewController;
        gtvc.gnomesDataSource = self.gnomesDataSource;
    }
}

#pragma mark - Data Handling

-(void)getGnomes:(GnomesTown)town{
    
    [self.playButton setHidden:YES];
    [self.tryAgainButton setHidden:YES];
    [self.spinner startAnimating];
    
    __weak typeof(UIButton) *wTryAgainButton = self.tryAgainButton;
    __weak typeof(UIButton) *wPlayButton = self.playButton;
    __weak typeof(self) wSelf = self;
    
    [[RestManager sharedManager] getGnomesForTown:town
                                          success:^(NSArray *gnomes) {
        [self populateGnomesList:gnomes];
        [self.spinner stopAnimating];
        [wPlayButton setHidden:NO]; }
                                          failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        [self.spinner stopAnimating];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:@"There was an error and we couldn't find any inhabitant 👹 in that town, please try again."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //Add a retry button to the alert controller
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Try again!!!"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             NSLog(@"Trying again...");
                                                             [wSelf getGnomes:Brastlewark];
                                                         }];
        //Add a cancel button to the alert controller
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"😳 I'm tired, it doesn't work."
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 NSLog(@"Just canceled by the user...");
                                                                 [wPlayButton setHidden:YES];
                                                                 [wTryAgainButton setHidden:NO];
                                                             }];
        [alertController addAction:actionOk];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

-(void)populateGnomesList:(NSArray*)gnomeList {
    
    __weak typeof(self) wSelf = self;
    [gnomeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Gnome* gnome = [[Gnome alloc] initWithConfiguration:obj];
        
        [wSelf.gnomesDataSource addObject:gnome];
    }];
}

- (IBAction)tryAgainPressed:(UIButton *)sender {
    [self getGnomes:Brastlewark];
}



@end

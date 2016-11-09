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
#import <AFNetworking.h>

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *tryAgainButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSMutableArray* gnomesDataSource;

@end

@implementation HomeViewController

static NSString * const kBaseURLString = @"https://raw.githubusercontent.com/AXA-GROUP-SOLUTIONS/mobilefactory-test/master/data.json";
static NSString * const kSegue = @"showGnomeTable";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.013 green:0.233 blue:0.227 alpha:1.00];
    [self.tryAgainButton setHidden:YES];
    [self.spinner setHidesWhenStopped:YES];
    self.gnomesDataSource = NSMutableArray.new;
    [self getGnomes:kBaseURLString];
}

-(void) viewWillAppear:(BOOL)animated {
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

-(void)getGnomes:(NSString*)url{
    
    [self.playButton setHidden:YES];
    [self.tryAgainButton setHidden:YES];
    [self.spinner startAnimating];
    
    //Gets JSON from URL and serialize it using AFNetworking.
    
    NSURL *URL = [NSURL URLWithString:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    __weak typeof(UIButton) *wTryAgainButton = self.tryAgainButton;
    __weak typeof(UIButton) *wPlayButton = self.playButton;
    __weak typeof(self) wSelf = self;
    
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *brastlewark = (NSArray*)[responseObject objectForKey:@"Brastlewark"];
            [self populateGnomesList:brastlewark];
        }

        [self.spinner stopAnimating];
        [wPlayButton setHidden:NO];
               
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.spinner stopAnimating];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:@"There was an error and we couldn't find any inhabitant 👹 in Brastlewark, please try again."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //Add a retry button to the alert controller
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Try again!!!"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             NSLog(@"Trying again...");
                                                             [wSelf getGnomes:kBaseURLString];
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

-(void) populateGnomesList: (NSArray*) gnomeList {
    
    [gnomeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Gnome* gnome = [[Gnome alloc] initWithConfiguration:obj];
        
        [self.gnomesDataSource addObject:gnome];
    }];
}

- (IBAction)tryAgainPressed:(UIButton *)sender {
    [self getGnomes:kBaseURLString];
}




@end

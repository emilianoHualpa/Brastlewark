//
//  GnomeTableViewController.m
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import "GnomeTableViewController.h"
#import "GnomeDetailViewController.h"
#import "GnomeTableViewCell.h"
#import "Gnome.h"
#import <UIImageView+AFNetworking.h>

@interface GnomeTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *searchBar;
@property (strong, nonatomic) NSMutableArray *filteredGnomes;
@property (assign, nonatomic) BOOL isSearchFiltered;

@end

@implementation GnomeTableViewController

static NSString *cellIdentifier = @"gnomeCell";
static NSString *segueIdentifier = @"showGnomeDetail";
static NSString *cellNibName = @"GnomeTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:cellNibName bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.searchBar.delegate = self;
    
    self.tableView.backgroundColor = [GnomeTableViewCell randomColor];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.isSearchFiltered) {
        return [self.gnomesDataSource count];
    } else {
        return [self.filteredGnomes count];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GnomeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:segueIdentifier sender:cell];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GnomeTableViewCell *cell = (GnomeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellNibName owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Get current Gnome for row
    Gnome* gnome;
    
    if (!self.isSearchFiltered) {
        // Get current Gnome for row
        gnome = (Gnome *)self.gnomesDataSource[indexPath.row];
    } else {
        // Get filtered Gnome for row
        gnome = (Gnome *)self.filteredGnomes[indexPath.row];
    }
    
    // Concatenate professions into String
    NSMutableString *professions = (NSMutableString*)[gnome.professions componentsJoinedByString:@", "];
    [professions appendString:@"."];
    
    // Download images asynchronously
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:gnome.thumbnailURL
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [cell.cellImageView setImageWithURLRequest:imageRequest placeholderImage:[UIImage imageNamed:@"placeholder"] success:nil failure:nil];

    // Set cell data
    cell.cellMainLabel.text = gnome.name;
    cell.cellDetailLabel.text = professions;
    cell.cellDetailLabel.numberOfLines = 2;
    cell.backgroundColor = [GnomeTableViewCell randomColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Same height as set in Nib.
    return 150;
}

#pragma mark - Search Bar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.isSearchFiltered = searchText.length == 0 ? NO : YES;
    
    if (self.isSearchFiltered) {
        self.filteredGnomes = NSMutableArray.new;
        
        __weak typeof(NSMutableArray) *wFilteredGnomes = self.filteredGnomes;
        
        [self.gnomesDataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [[(Gnome*)obj name] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (range.location != NSNotFound) {
                [wFilteredGnomes addObject:obj];
            }
        }];
    }
    
    [self.tableView reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar endEditing:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showGnomeDetail"]) {
        
        GnomeDetailViewController *gDetailVC = segue.destinationViewController;
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        gDetailVC.gnome = (Gnome *)self.gnomesDataSource[index.row];
        gDetailVC.backgroundColor = [(GnomeTableViewCell*)sender backgroundColor];
    }
}


@end

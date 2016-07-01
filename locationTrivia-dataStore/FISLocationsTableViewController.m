//
//  FISLocationsTableViewController.m
//  locationTrivia-dataStore
//
//  Created by Ryan Cohen on 6/30/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISLocationsDataStore.h"
#import "FISLocation.h"
#import "FISTrivium.h"

#import "FISLocationsTableViewController.h"
#import "FISTriviaTableViewController.h"

@interface FISLocationsTableViewController ()

@property (nonatomic, strong) FISLocationsDataStore *store;

@end

@implementation FISLocationsTableViewController

#pragma mark - Table

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Locations";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.store.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    FISLocation *location = (FISLocation *)self.store.locations[indexPath.row];
    
    cell.textLabel.text = location.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu trivi%@", location.trivia.count, (location.trivia.count > 1) ? @"a" : @"um"];
    
    return cell;
}

#pragma mark - Dummy

- (NSArray *)generateStartingLocationsData {
    FISLocation *empireState = [[FISLocation alloc] initWithName:@"The Empire State Building"
                                                        latitude:40.7484
                                                       longitude:-73.9857];
    
    FISTrivium *trivium1A = [[FISTrivium alloc] initWithContent:@"1,454 Feet Tall" likes:4];
    FISTrivium *trivium1B = [[FISTrivium alloc] initWithContent:@"Cost $24,718,000 to build" likes:2];
    
    [empireState.trivia addObjectsFromArray:@[trivium1A, trivium1B]];
    
    FISLocation *bowlingGreen = [[FISLocation alloc] initWithName:@"Bowling Green"
                                                         latitude:41.3739
                                                        longitude:-83.6508];
    
    FISTrivium *trivium2A = [[FISTrivium alloc] initWithContent:@"NYC's oldest park" likes:8];
    FISTrivium *trivium2B = [[FISTrivium alloc] initWithContent:@"Made a park in 1733" likes:2];
    FISTrivium *trivium2C = [[FISTrivium alloc] initWithContent:@"Charging Bull was created in 1989" likes:0];
    
    
    [bowlingGreen.trivia addObjectsFromArray:@[trivium2A, trivium2B, trivium2C]];
    
    FISLocation *ladyLiberty = [[FISLocation alloc] initWithName:@"Statue Of Liberty"
                                                        latitude:40.6892
                                                       longitude:74.0444];
    
    FISTrivium *trivium3A = [[FISTrivium alloc] initWithContent:@"Gift from the french" likes:6];
    
    [ladyLiberty.trivia addObjectsFromArray:@[trivium3A]];
    
    return @[bowlingGreen, empireState, ladyLiberty];
}

#pragma mark - View;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Location Trivia";
    self.tableView.accessibilityLabel = @"Locations Table";
    
    self.navigationItem.rightBarButtonItem.accessibilityLabel = @"addButton";
    self.navigationItem.rightBarButtonItem.accessibilityIdentifier = @"addButton";
    
    self.store = [[FISLocationsDataStore sharedInstance] initWithLocations:[self generateStartingLocationsData]];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.store.locations sortUsingComparator:^NSComparisonResult(FISLocation *location1, FISLocation *location2) {
        if (location1.trivia.count > location2.trivia.count) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ToTrivia"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FISLocation *location = self.store.locations[indexPath.row];
        
        FISTriviaTableViewController *trivia = (FISTriviaTableViewController *)[segue destinationViewController];
        trivia.location = location;
    }
}

@end

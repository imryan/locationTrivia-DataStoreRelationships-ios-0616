//
//  FISTriviaTableViewController.m
//  locationTrivia-dataStore
//
//  Created by Ryan Cohen on 6/30/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISLocation.h"
#import "FISTrivium.h"

#import "FISTriviaTableViewController.h"
#import "FISAddTriviaViewController.h"

@implementation FISTriviaTableViewController

#pragma mark - Table

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Trivia";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.location.trivia.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.rightUtilityButtons = [self rightUtilityItems];
    
    FISTrivium *trivium = (FISTrivium *)self.location.trivia[indexPath.row];
    
    cell.textLabel.text = trivium.content;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu like%@", trivium.likes,
                                 (trivium.likes > 1) || (trivium.likes == 0) ? @"s" : @""];
    
    return cell;
}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    FISTrivium *trivium = (FISTrivium *)self.location.trivia[indexPath.row];
    
    trivium.likes++;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

- (NSArray *)rightUtilityItems {
    NSMutableArray *buttons = [NSMutableArray new];
    [buttons sw_addUtilityButtonWithColor:[UIColor colorWithRed:49/255.f
                                                          green:130/255.f
                                                           blue:217/255.f
                                                          alpha:1.f] title:@"Like"];
    
    return buttons;
}

#pragma mark - View;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.location.name;
    self.tableView.accessibilityLabel = @"Trivia Table";
    self.tableView.accessibilityIdentifier = @"Trivia Table";
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ToAddTrivium"]) {
        FISAddTriviaViewController *addTrivia = (FISAddTriviaViewController *)[segue destinationViewController];
        addTrivia.location = self.location;
    }
}

@end

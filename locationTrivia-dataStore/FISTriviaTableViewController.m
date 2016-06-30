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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    FISTrivium *trivium = (FISTrivium *)self.location.trivia[indexPath.row];
    
    cell.textLabel.text = trivium.content;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu likes", trivium.likes];
    
    return cell;
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

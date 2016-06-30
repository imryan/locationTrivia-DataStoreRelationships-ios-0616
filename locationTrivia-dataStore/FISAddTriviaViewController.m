//
//  FISAddTriviaViewController.m
//  locationTrivia-dataStore
//
//  Created by Ryan Cohen on 6/30/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISLocation.h"
#import "FISLocationsDataStore.h"

#import "FISAddTriviaViewController.h"

@interface FISAddTriviaViewController ()

@property (nonatomic, strong) IBOutlet UITextField *triviumTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)add:(id)sender;

@end

@implementation FISAddTriviaViewController

#pragma mark - Actions

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)add:(id)sender {
    FISTrivium *trivium = [[FISTrivium alloc] initWithContent:self.triviumTextField.text likes:0];
    [self.location.trivia addObject:trivium];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.triviumTextField becomeFirstResponder];
    
    self.title = [NSString stringWithFormat:@"Add Trivium @ %@", self.location.name];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

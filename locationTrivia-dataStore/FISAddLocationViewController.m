//
//  FISAddLocationViewController.m
//  locationTrivia-dataStore
//
//  Created by Ryan Cohen on 6/30/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISLocationsDataStore.h"
#import "FISLocation.h"

#import "FISAddLocationViewController.h"

@interface FISAddLocationViewController ()

@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UIButton *coordinatesButton;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

- (IBAction)getLocation:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@implementation FISAddLocationViewController

#pragma mark - Actions

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)add:(id)sender {
    CLLocation *currentLocation = self.locationManager.location;
    FISLocation *location = [[FISLocation alloc] initWithName:self.nameTextField.text
                                                     latitude:currentLocation.coordinate.latitude
                                                    longitude:currentLocation.coordinate.longitude];
    
    [[FISLocationsDataStore sharedInstance].locations addObject:location];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getLocation:(id)sender {
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    while (!self.locationManager.location) {
        [self.locationManager startUpdatingLocation];
    }
    
    NSString *coordinates = [NSString stringWithFormat:@"You're at (%f, %f)", self.locationManager.location.coordinate.latitude,
                                                                              self.locationManager.location.coordinate.longitude];
    
    self.coordinatesButton.enabled = NO;
    [self.coordinatesButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.coordinatesButton setTitle:coordinates forState:UIControlStateDisabled];
    
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nameTextField becomeFirstResponder];
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    self.navigationItem.leftBarButtonItem.accessibilityLabel = @"cancelButton";
    self.navigationItem.leftBarButtonItem.accessibilityIdentifier = @"cancelButton";
    
    self.navigationItem.rightBarButtonItem.accessibilityLabel = @"saveButton";
    self.navigationItem.rightBarButtonItem.accessibilityIdentifier = @"saveButton";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

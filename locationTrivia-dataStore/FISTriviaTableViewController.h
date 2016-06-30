//
//  FISTriviaTableViewController.h
//  locationTrivia-dataStore
//
//  Created by Ryan Cohen on 6/30/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FISLocation;

@interface FISTriviaTableViewController : UITableViewController

@property (nonatomic, strong) FISLocation *location;

@end

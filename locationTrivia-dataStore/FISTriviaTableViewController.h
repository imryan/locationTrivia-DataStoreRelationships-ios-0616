//
//  FISTriviaTableViewController.h
//  locationTrivia-dataStore
//
//  Created by Ryan Cohen on 6/30/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@class FISLocation;

@interface FISTriviaTableViewController : UITableViewController <SWTableViewCellDelegate>

@property (nonatomic, strong) FISLocation *location;

@end

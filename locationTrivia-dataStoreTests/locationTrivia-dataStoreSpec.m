//
//  locationTrivia-dataStoreSpec.m
//  locationTrivia-dataStore
//
//  Created by Mykel Pereira on 3/17/15.
//  Copyright 2015 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"
#import "FISLocation.h"
#import "FISTrivium.h"
#import "FISLocationsTableViewController.h"
#import "FISAppDelegate.h"
#import "FISLocationsDataStore.h"

SpecBegin(locationTriviaDataStore)

describe(@"locationTriviaDataStore", ^{
    
    __block NSMutableArray *locations = [FISLocationsDataStore sharedInstance].locations;
    
    __block UINavigationController *navCon;
    
    beforeAll(^{
    
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        navCon = [main instantiateInitialViewController];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = navCon;
        
    });
    
    describe(@"Locations Table View", ^{
        __block UITableView *table;
        
        beforeEach(^{
            [FISLocationsDataStore sharedInstance].locations = locations;
            table = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"Locations Table"];
        });
        
        
        it(@"should display the name in the textLabel", ^{
            NSIndexPath *row = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            
            expect(cell.textLabel.text).to.equal(@"Bowling Green");
            
            row = [NSIndexPath indexPathForRow:1 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            
            expect(cell.textLabel.text).to.equal(@"The Empire State Building");
            
            row = [NSIndexPath indexPathForRow:2 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            
            expect(cell.textLabel.text).to.equal(@"Statue Of Liberty");
        });
        
        it(@"should display the number of trivia in the detailTextLabel", ^{
            NSIndexPath *row = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            
            expect(cell.detailTextLabel.text).to.equal(@"3 trivia");
            
            row = [NSIndexPath indexPathForRow:1 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            
            expect(cell.detailTextLabel.text).to.equal(@"2 trivia");
            
            row = [NSIndexPath indexPathForRow:2 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            
            expect(cell.detailTextLabel.text).to.equal(@"1 trivium");
        });
        
        it(@"Should push on trivia VC when a cell is tapped", ^{
            NSIndexPath *row = [NSIndexPath indexPathForRow:0 inSection:0];
            [tester tapRowAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            [tester waitForViewWithAccessibilityLabel:@"Trivia Table"];
            [tester tapViewWithAccessibilityLabel:@"Back"];
        });
        
    });
    
    describe(@"Trivia ViewController", ^{
        __block UITableView *table;
        beforeEach(^{
            [FISLocationsDataStore sharedInstance].locations = locations;
            NSIndexPath *row = [NSIndexPath indexPathForRow:1 inSection:0];
            [tester tapRowAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            table = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"Trivia Table"];
        });
        
        it(@"Should display 2 trivia", ^{
            expect([table numberOfRowsInSection:0]).to.equal(2);
        });
        
        it(@"Should display the trivia content in each textLabel", ^{
            NSIndexPath *row = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Trivia Table"];
            
            expect(cell.textLabel.text).to.equal(@"1,454 Feet Tall");
            
            row = [NSIndexPath indexPathForRow:1 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Trivia Table"];
            
            expect(cell.textLabel.text).to.equal(@"Cost $24,718,000 to build");
        });
        
        afterEach(^{
            [tester tapViewWithAccessibilityLabel:@"Back"];
        });
    });
    
    describe(@"Add Trivium", ^{
        __block UITableView *table;
        __block UITextField *triviumTextField;
        __block NSString *triviumText = @"Flatiron School is Here";

        beforeEach(^{
            [FISLocationsDataStore sharedInstance].locations = locations;
            NSIndexPath *row = [NSIndexPath indexPathForRow:0 inSection:0];
            [tester tapRowAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Locations Table"];
            table = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"Trivia Table"];
            [tester tapViewWithAccessibilityLabel:@"Add Trivia Button"];
        });
        
        it(@"Should Dismiss View Controller when cancel button tapped", ^{
            [tester tapViewWithAccessibilityLabel:@"Cancel Button"];
            [tester waitForViewWithAccessibilityLabel:@"Trivia Table"];
            // add expect statement
            [tester tapViewWithAccessibilityLabel:@"Add Trivia Button"];
        });
        
        it(@"Should save trivium when save button tapped", ^{
            triviumTextField = (UITextField *)[tester waitForViewWithAccessibilityLabel:@"Trivium TextField"];
            triviumTextField.text = triviumText;
            
            [tester tapViewWithAccessibilityLabel:@"Save Button"];
            [tester waitForViewWithAccessibilityLabel:@"Trivia Table"];
            
            NSIndexPath *row = [NSIndexPath indexPathForRow:3 inSection:0];
            UITableViewCell *cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"Trivia Table"];
            
            expect(cell.textLabel.text).to.equal(triviumText);
            [tester tapViewWithAccessibilityLabel:@"Add Trivia Button"];
        });
        
        afterEach(^{
            [tester tapViewWithAccessibilityLabel:@"Cancel Button"];
            [tester tapViewWithAccessibilityLabel:@"Back"];
        });
    });
});

SpecEnd

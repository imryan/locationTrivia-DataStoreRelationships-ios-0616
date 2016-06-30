//
//  FISLocationsDataStore.h
//  locationTrivia-dataStore
//
//  Created by Ryan Cohen on 6/30/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISLocationsDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *locations;

+ (instancetype)sharedInstance;

- (instancetype)initWithLocations:(NSArray *)locations;

@end

//
//  FISLocationsDataStore.m
//  locationTrivia-dataStore
//
//  Created by Ryan Cohen on 6/30/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISLocationsDataStore.h"

@implementation FISLocationsDataStore

#pragma mark - Init

- (instancetype)init {
    return [self initWithLocations:@[]];
}

- (instancetype)initWithLocations:(NSArray *)locations {
    self = [super init];
    if (self) {
        _locations = [NSMutableArray arrayWithArray:locations];
    }
    
    return self;
}

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static FISLocationsDataStore *dataStore = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dataStore = [self new];
    });
    
    return dataStore;
}

@end

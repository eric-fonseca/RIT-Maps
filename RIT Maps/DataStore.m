//
//  DataStore.m
//  National Parks
//
//  Created by Eric Fonseca on 10/16/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore

+ (id)sharedStore{
    static DataStore *sharedStore = nil;
    
    //Do I need to create a sharedStore?
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

//If a programmer calls [[DataStore alloc] init], let him know the error of his ways
- (instancetype) init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[DataStore sharedStore]!" userInfo:nil];
    return nil;
}

//Here is the real (secret) initializer
- (instancetype)initPrivate{
    self = [super init];
    if(self){
        self.allItems = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

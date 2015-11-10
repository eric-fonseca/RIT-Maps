//
//  DataStore.h
//  National Parks
//
//  Created by Eric Fonseca on 10/16/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject
@property (nonatomic) NSMutableArray *allItems;

+(instancetype)sharedStore;

@end

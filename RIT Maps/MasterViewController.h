//
//  MasterViewController.h
//  RIT Maps
//
//  Created by Eric Fonseca on 10/30/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"
#import "RITBuilding.h"
#import "DetailViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) RITBuilding *building;
@property (strong, nonatomic) NSMutableArray *buildings;
@property (strong, nonatomic) NSMutableArray *objects;
@property (strong, nonatomic) UISearchBar *uiSearchBar;
@property (strong, nonatomic) NSArray *searchResults;

@end


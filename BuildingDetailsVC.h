//
//  BuildingDetailsVC.h
//  RIT Maps
//
//  Created by Eric Fonseca on 11/8/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RITBuilding.h"
#import "MasterViewController.h"

@interface BuildingDetailsVC : UIViewController <UIWebViewDelegate>
@property (nonatomic, strong) RITBuilding *building;
@property (nonatomic, strong) NSObject *annotation;

@end

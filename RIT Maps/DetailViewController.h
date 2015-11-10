//
//  DetailViewController.h
//  RIT Maps
//
//  Created by Eric Fonseca on 10/30/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import <UIKit/UIKit.h>
#import "RITBuilding.h"
#import "DataStore.h"
#import "BuildingDetailsVC.h"
#import "MyMarker.h"
@import MapKit;

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, MKMapViewDelegate, UIPopoverControllerDelegate, UIWebViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSMutableArray *buildings;
@property (nonatomic) float currentRegionSize;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmentedControl;
@property (strong, nonatomic) RITBuilding *building;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSMutableArray *markers;
@property (strong, nonatomic) UIPopoverController *popOver;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(void)configureView;
-(void)zoomTo:(id<MKAnnotation>)annotation;

@end


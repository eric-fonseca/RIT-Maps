//
//  DetailViewController.m
//  RIT Maps
//
//  Created by Eric Fonseca on 10/30/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "DetailViewController.h"

#define METERS_PER_MILE 1609.344

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

//display the info button and RIT image in building callout
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    UIImage *image = [UIImage imageNamed:@"rit-orange-no-bar"];
    UIImageView *imgView =[[UIImageView alloc] initWithImage:image];
    annotationView.leftCalloutAccessoryView = imgView;
    
    return annotationView;
}

//change the type of map that is displayed
- (IBAction)mapTypeChanged:(id)sender {
    switch (self.mapTypeSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}

//set the value of the detailItem
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
    if(self.popOver != nil){
        [self.popOver dismissPopoverAnimated:YES];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = [self.detailItem latitude];
        zoomLocation.longitude = [self.detailItem longitude];
        
        //set zoom level
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, METERS_PER_MILE/20, METERS_PER_MILE/20);
        MyMarker *currentSelection = [[MyMarker alloc] initWithTitle:[self.detailItem name] Coordinate:CLLocationCoordinate2DMake([self.detailItem latitude], [self.detailItem longitude])];
        currentSelection.subtitle = [self.detailItem abbreviation];
        [self.mapView addAnnotation:currentSelection];
        [self zoomTo:currentSelection];
        self.building = self.detailItem;
        [self.mapView setRegion:viewRegion animated:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    self.buildings = [DataStore sharedStore].allItems;
    self.markers = [NSMutableArray array];
    
    //ask for the user's current location and display it on the map
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    #ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    #endif
    [self.locationManager startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
    
    //create markers
    for(int i = 0; i < self.buildings.count; i++){
        RITBuilding *building = self.buildings[i];
        MyMarker *marker = [[MyMarker alloc] initWithTitle:building.name Coordinate:CLLocationCoordinate2DMake(building.latitude, building.longitude)];
        marker.subtitle = building.abbreviation;
        self.detailItem = building;
        [self.markers addObject:marker];
    }
    self.detailItem = self.buildings[22]; //select the George Eastman building on start up
    
    [self.mapView addAnnotations:self.markers];

    [self configureView];
}

//zoom to marker
- (void)zoomTo:(id<MKAnnotation>)annotation{
    self.tabBarController.selectedIndex = 0;
    [self.mapView selectAnnotation:annotation animated:YES];
}

//set the building popover details to the selected building
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    for(int i = 0; i<self.buildings.count; i++){
        if(view.annotation.title == [self.buildings[i] name]){
            self.building = self.buildings[i];
        }
    }
    
    if(![view.annotation.title isEqual: @"Current Location"]){ //do not display a popover if the user selects their current location because there is no info to display
        [mapView deselectAnnotation:view.annotation animated:YES];
        BuildingDetailsVC *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsPopover"];
        controller.annotation = view.annotation;
        controller.building = self.building;
        self.popOver = [[UIPopoverController alloc] initWithContentViewController:controller];
        self.popOver.delegate = self;
        [self.popOver presentPopoverFromRect:view.frame inView:view.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

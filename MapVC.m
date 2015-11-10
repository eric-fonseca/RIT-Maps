//
//  MapVC.m
//  National Parks
//
//  Created by Eric Fonseca on 10/9/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "MapVC.h"
#import "MyMarker.h"
#import "DataStore.h"
@import MapKit;

#define METERS_PER_MILE 1609.344

@interface MapVC ()
@property (nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSMutableArray *markers;
@property (nonatomic) CLLocationManager *lm;
@end

@implementation MapVC

//called before viewDidLoad
- (void)awakeFromNib{
    //register for @"ZoomNotification"
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(receiveZoomNotification:)
     name:@"ZoomNotification"
     object:nil];
}

- (void)receiveZoomNotification:(NSNotification *)notification{
    id<MKAnnotation> annotation = notification.userInfo[@"annotation"];
    [self zoomTo:annotation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 43.1656;
    zoomLocation.longitude = -77.6114;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 30*METERS_PER_MILE, 1000*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];*/
    
    //Part D
    self.markers = [NSMutableArray array];
    
    MyMarker *m1 = [[MyMarker alloc]initWithTitle:@"Victor" Coordinate:CLLocationCoordinate2DMake(42.98, -77.41)];
    MyMarker *m2 = [[MyMarker alloc]initWithTitle:@"Webster" Coordinate:CLLocationCoordinate2DMake(43.2089, -77.4594)];
    MyMarker *m3 = [[MyMarker alloc]initWithTitle:@"IGM" Coordinate:CLLocationCoordinate2DMake(43.083848, -77.6799)];
    [self.markers addObject: m1];
    [self.markers addObject: m2];
    [self.markers addObject: m3];
    m1.subtitle = @"Where life isn't worth living";
    m2.subtitle = @"Where life is worth living";
    m3.subtitle = @"Where we design great apps";
    
    
    //now add the array of annotations to the map
    //[self.mapView addAnnotations:self.markers];
    [self.mapView addAnnotations:[DataStore sharedStore].allItems];
    [self startUpdatingLocation];
    //[self zoomTo:self.mapView.annotations[0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)zoomTo:(id<MKAnnotation>)annotation{
    //change to this tab
    self.tabBarController.selectedIndex = 0;
    [self.mapView selectAnnotation:annotation animated:YES];
}

- (void)startUpdatingLocation{
    if(self.lm == nil) self.lm = [[CLLocationManager alloc]init];
    [self.lm requestWhenInUseAuthorization];
    self.lm.desiredAccuracy = kCLLocationAccuracyBest;
    self.lm.distanceFilter = 20;
    self.lm.delegate = self;
    [self.lm startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate protocol methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation* location = [locations lastObject];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500*METERS_PER_MILE, 500*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
    NSLog(@"updated location = %@", location);
}

//if there's an error, tell us
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error = %@", error);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

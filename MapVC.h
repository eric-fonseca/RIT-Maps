//
//  MapVC.h
//  National Parks
//
//  Created by Eric Fonseca on 10/9/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@import CoreLocation;

@interface MapVC : UIViewController<CLLocationManagerDelegate>

- (void)zoomTo:(id<MKAnnotation>)annotation;

@end

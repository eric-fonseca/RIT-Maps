//
//  MyMarker.h
//  National Parks
//
//  Created by Eric Fonseca on 10/9/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface MyMarker : NSObject<MKAnnotation>
@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

-(id)initWithTitle:(NSString*)title Coordinate:(CLLocationCoordinate2D)coord;

@end

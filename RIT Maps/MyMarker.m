//
//  MyMarker.m
//  National Parks
//
//  Created by Eric Fonseca on 10/9/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "MyMarker.h"

@implementation MyMarker
-(id)initWithTitle:(NSString *)title Coordinate:(CLLocationCoordinate2D)coord{
    self = [super init];
    if(self){
        _title = title;
        _coordinate = coord;
    }
    return self;
}

@end

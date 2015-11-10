//
//  RITBuilding.m
//  RIT Maps
//
//  Created by Eric Fonseca on 11/4/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "RITBuilding.h"

@implementation RITBuilding

-(instancetype) initWithName: (NSString*)name mdo_id:(NSString*)mdo_id bDescription:(NSString*)bDescription polygon_id:(NSString*)polygon_id image:(NSString*)image abbreviation:(NSString*)abbreviation history:(NSString*)history fulldescription:(NSString*)fulldescription latitude:(float)latitude longitude:(float)longitude;{
    self = [super init];
    if(self){
        self.name = name;
        self.mdo_id = mdo_id;
        self.bDescription = bDescription;
        self.polygon_id = polygon_id;
        self.image = image;
        self.abbreviation = abbreviation;
        self.history = history;
        self.fulldescription = fulldescription;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (NSString*)title{
    return self.name;
}

- (NSString*)subtitle{
    return self.abbreviation;
}

- (id)initWithTitle:(NSString *)title Coordinate:(CLLocationCoordinate2D)coord{
    self = [super init];
    if(self){
        _title = self.title;
        _subtitle =self.subtitle;
        _coordinate = self.coordinate;
    }
    return self;
}

//parse path for overlays
- (NSMutableArray *)parsePath:(NSString *)path{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *points = [path componentsSeparatedByString:@"|"];
    for (NSString *p in points) {
        NSArray *values = [p componentsSeparatedByString:@","];
        float latitude = [values[0] floatValue];
        float longitude = [values[1] floatValue];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude,longitude);
        [array addObject: [NSValue valueWithMKCoordinate: coordinate]];
    }
    return array;
}

@end

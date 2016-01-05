//
//  ViewController.m
//  CoffeeFindr
//
//  Created by Rafael Auriemo on 1/4/16.
//  Copyright (c) 2016 Rafael Auriemo. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CoffeePlace.h"

@interface ViewController () <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;
@property NSArray *coffeePlaces;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    self.currentLocation = [CLLocation new];
    self.locationManager.delegate = self;
    [self updateCurrentLocation];
}

-(void) updateCurrentLocation {
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

-(void)findCoffeeShops:(CLLocation *)location{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"coffee";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.05, 0.05));
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSArray *mapItems = response.mapItems;
//        NSLog(@"%lu", mapItems.count);
        NSMutableArray *tempArray = [NSMutableArray new];
        for (int i = 0; i < mapItems.count; i++) {
            MKMapItem *mapItem = mapItems[i];
            CLLocationDistance metersAway = [mapItem.placemark.location distanceFromLocation:location];
            float kmAway = metersAway / 1000;
            CoffeePlace *coffeePlace = [CoffeePlace new];
            coffeePlace.mapItem = mapItem;
            coffeePlace.kmAway = kmAway;
            [tempArray addObject:coffeePlace];
//            NSLog(@"%@", coffeePlace.mapItem.name);
//            NSLog(@"%f", coffeePlace.kmAway);
        }
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"kmAway" ascending:true];
        NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:@[sortDescriptor]];
        self.coffeePlaces = [NSArray arrayWithArray:sortedArray];
//        for (int i = 0; i<self.coffeePlaces.count; i++) {
//            NSLog(@"%f", [self.coffeePlaces[i] kmAway]);
//        }
    }];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.currentLocation = locations.firstObject;
    [self.locationManager stopUpdatingLocation];
    [self findCoffeeShops:self.currentLocation];
    NSLog(@"%@", self.currentLocation);
}

@end

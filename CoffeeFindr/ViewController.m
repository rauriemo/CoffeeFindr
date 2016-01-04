//
//  ViewController.m
//  CoffeeFindr
//
//  Created by Rafael Auriemo on 1/4/16.
//  Copyright (c) 2016 Rafael Auriemo. All rights reserved.
//

#import "ViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface ViewController () <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
}


@end

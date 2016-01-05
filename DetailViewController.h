//
//  DetailViewController.h
//  
//
//  Created by Rafael Auriemo on 1/4/16.
//
//

#import <UIKit/UIKit.h>
#import "CoffeePlace.h"

@interface DetailViewController : UIViewController

@property CoffeePlace *coffeePlace;
@property CLLocation *currentLocation;

@end

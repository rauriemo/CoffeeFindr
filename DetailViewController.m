//
//  DetailViewController.m
//  
//
//  Created by Rafael Auriemo on 1/4/16.
//
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.coffeePlace.mapItem.name;
    [self getPathDirections:self.currentLocation.coordinate withDestination:self.coffeePlace.mapItem.placemark.location.coordinate];
}

-(void) getPathDirections:(CLLocationCoordinate2D)source withDestination:(CLLocationCoordinate2D) destination {
    MKPlacemark *placemarkSrc = [[MKPlacemark alloc] initWithCoordinate:source addressDictionary:nil];
    MKMapItem *mapSrc = [[MKMapItem alloc] initWithPlacemark:placemarkSrc];
    
    MKPlacemark *placemarkDest = [[MKPlacemark alloc] initWithCoordinate:destination addressDictionary:nil];
    MKMapItem *mapDest = [[MKMapItem alloc] initWithPlacemark:placemarkDest];
    
    MKDirectionsRequest *request = [MKDirectionsRequest new];
    [request setSource:mapSrc];
    [request setDestination:mapDest];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        MKRoute *route = response.routes.lastObject;
        NSString *fullInstructions = [NSString new];
        for (int i=0; i<route.steps.count; i++) {
            MKRouteStep *step = route.steps[i];
            NSString *stepInstruction = step.instructions;
            fullInstructions = [fullInstructions stringByAppendingString:stepInstruction];
            fullInstructions = [fullInstructions stringByAppendingString:@"\n\n"];
        }
        self.textView.text = fullInstructions;
    }];
    
}
@end

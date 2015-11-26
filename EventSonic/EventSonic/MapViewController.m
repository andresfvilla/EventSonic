//
//  MapViewController.m
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@end

@implementation MapViewController{
    GMSMapView *mapView_;
    CLGeocoder * geocoder;
    CLPlacemark * placemark;
    CLLocation * userLocation;
}

@synthesize eventCount, events, eventInfo, manager;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //gets the users location and instantiates the map at that location
    
    //this is to retrieve the users current location
   
    //this is
        self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    if([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];

    geocoder = [[CLGeocoder alloc] init];
    


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)click:(UIButton *)b{
    NSLog(@"This responded to a click");
}

-(void)setupGoogleMap{
    //uses haversines formula to find the distance around the globe using latitude and longitude of 2 points
//    ZFHaversine * distanceAndBearing = [[ZFHaversine alloc] init];
//    [distanceAndBearing setLatitude1:mapView_.camera.target.latitude];
//    [distanceAndBearing setLongitude1:mapView_.camera.target.longitude];
//    
//    [distanceAndBearing setLatitude2:userLocation.coordinate.latitude];
//    [distanceAndBearing setLongitude2:userLocation.coordinate.longitude];
    ZFHaversine *distanceAndBearing = [[ZFHaversine alloc] initWithLatitude1:mapView_.myLocation.coordinate.latitude
                                                                  longitude1:mapView_.myLocation.coordinate.longitude
                                                                   latitude2:userLocation.coordinate.latitude
                                                                  longitude2:userLocation.coordinate.longitude];
   // NSLog(@"mapview.camera: %f, %f", mapView_.camera.target.latitude, mapView_.camera.target.longitude);
   // NSLog(@"userLocation: %f, %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
//    NSLog(@"%f\n\n", [distanceAndBearing miles]);
    //if the user is still within a certain distance, theres no reason to reset the camera, if its null though, override the value since it hasnt been instantiated
    
    if(mapView_.camera == NULL){
         NSLog(@"hitting this");
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: manager.location.coordinate.latitude
                                                                longitude: manager.location.coordinate.longitude
                                                                     zoom:10];
        mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapView_.myLocationEnabled = YES;
        self.view = mapView_;
    
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
        marker.title = @"Miami";
        marker.snippet = @"Florida";
        marker.map = mapView_;
    }
    if([distanceAndBearing miles]>=10){
    }
    [Events getEvents];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location! :(");
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //NSLog(@"Location: %@", [locations objectAtIndex:[locations count]-1]);
    CLLocation * currentLocation = [locations objectAtIndex:[locations count]-1];
    if(currentLocation !=nil){
        //set your variables to keep track of the location
        //NSLog(@"%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        //NSLog(@"%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
    }
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(error == nil && [placemarks count] > 0){
            placemark = [placemarks lastObject];
       //     NSLog(@"%@",[NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@", placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country]);
        }
        else{
         //   NSLog(@"%@", error.debugDescription);
        }
    }];
    userLocation = currentLocation;
    [self setupGoogleMap];
}

@end

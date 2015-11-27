//
//  MapViewController.m
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController{
    GMSMapView *mapView_;
    CLGeocoder * geocoder;
    CLPlacemark * placemark;
    CLLocation * userLocation;
}

@synthesize eventCount, events, eventInfo, manager;
@synthesize name, time;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.    
    
    //this is used to find the useres current location
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
//    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext * context = [appDelegate managedObjectContext];
//    NSManagedObject * newContact;
//    
//    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Events" inManagedObjectContext:context];
//    [newContact setValue: @"???" forKey:@"???"];
//    [self.name addObject: @"???"];
//    [newContact setValue:@"???" forKey:@"???"];
//    [self.time addObject:@"???"];
//    [newContact setValue:@"???" forKey:@"???"];
//    [self.time addObject:@"???"];
//    NSError * error;
//    [context save:&error];
//    NSLog(@"saved some stuff");
}

-(void)setupGoogleMap{
    //uses haversines formula to find the distance around the globe using latitude and longitude of 2 points
    ZFHaversine *distanceAndBearing = [[ZFHaversine alloc] initWithLatitude1:mapView_.myLocation.coordinate.latitude
                                                                  longitude1:mapView_.myLocation.coordinate.longitude
                                                                   latitude2:userLocation.coordinate.latitude
                                                                  longitude2:userLocation.coordinate.longitude];
    //NSLog(@"mapview.camera: %f, %f", mapView_.camera.target.latitude, mapView_.camera.target.longitude);
    //NSLog(@"userLocation: %f, %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    //NSLog(@"%f\n\n", [distanceAndBearing miles]);
    //if the user is still within a certain distance, theres no reason to reset the camera, if its null though, override the value since it hasnt been instantiated
    if(mapView_.camera == NULL){
         NSLog(@"hitting this");
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: manager.location.coordinate.latitude
                                                                longitude: manager.location.coordinate.longitude
                                                                     zoom:14];
        mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapView_.myLocationEnabled = YES;
        mapView_.delegate = self;
        self.view = mapView_;
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(manager.location.coordinate.latitude, manager.location.coordinate.longitude);
        marker.title = @"apple";
        marker.snippet = @"Offices";
        marker.map = mapView_;
    }
    if([distanceAndBearing miles]>=10){
        
    }
   // [Events getEvents];
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    NSLog(@"found a tap and creating new event");
    
    
    //EventsController * vc = [[EventsController alloc] init];
    
    //[self presentViewController:vc animated:YES completion:nil];
    
    UIStoryboard * storyboard = self.storyboard;
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
     vc.callingView = self;
    [self presentViewController:vc animated:YES completion:nil];
    vc.location.text = [NSString stringWithFormat:@"%f,%f",coordinate.latitude, coordinate.longitude];

    //take him to a new card for an event
   // Events * event = [[Events alloc] init];
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    //this will be used to take you to the detail page of that marker, if you have permissions and owner, you can edit that marker also
    NSLog(@"Found a tap on a marker");
    return YES;
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

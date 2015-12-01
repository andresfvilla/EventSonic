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
    CLGeocoder * geocoder;//converts coordinates to address, and vice versa
    CLPlacemark * placemark;
    CLLocation * userLocation;
}

@synthesize eventCount, events, manager, desiredRadius, mapView_, markerList, eventController;
- (void)viewDidLoad {
    [super viewDidLoad];
    if([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied){
//        NSLog(@"need location services");
//        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Location Services"
//                                                        message:@"Please enable location services"
//                                                       delegate:self
//                                              cancelButtonTitle:@"Settings"
//                                              otherButtonTitles: nil];
//        [alert show];

    }
    
    
    //this is used to find the users current location
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    if([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];//Begins searching for the users location

    geocoder = [[CLGeocoder alloc] init];
    desiredRadius = [NSNumber numberWithDouble:3];
}

-(void)viewDidAppear:(BOOL)animated{
    //Fetches the list of events from Core Data
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    self.events = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    //Clears all the markers from the map
    [mapView_ clear];
    markerList = [[NSMutableArray alloc] init];

    //Will add the users current location as a marker on the map, and then adds markers that are only within a user specified range(default 3) to display on the map
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(manager.location.coordinate.latitude, manager.location.coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"You Are Here";
    marker.map = mapView_;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: manager.location.coordinate.latitude
                                                            longitude: manager.location.coordinate.longitude
                                                                 zoom:14];
    mapView_.camera = camera;
    [markerList addObject:marker];
    //will show the markers for the events, shows when, where, and the distance to that event from the users current location
    for(int i =0; i<events.count; i++){
        Event * event = [events objectAtIndex:i];
        NSArray * latLong = [event.location componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        CLLocation * position = [[CLLocation alloc] initWithLatitude:[[latLong objectAtIndex:0] doubleValue] longitude:[[latLong objectAtIndex:1] doubleValue]];
        if(([position distanceFromLocation:manager.location]/1609.34)<=[desiredRadius doubleValue]){
            GMSMarker *marker = [GMSMarker markerWithPosition:position.coordinate];
            marker.title = event.name;
            marker.map = mapView_;
            marker.userData = event;
            marker.snippet = [NSString stringWithFormat:@"When: %@\nWhere: %@\nDistance: %f miles", event.date, event.details, [position distanceFromLocation:manager.location]];
            [markerList addObject:marker];
        }

    }
}

-(NSManagedObjectContext *)managedObjectContext{
    //finds the applications appdelegate, casts it to the type of our appdelegate and then it will find the managedobjectcontext
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupGoogleMap{
    //if the user is still within a certain distance, theres no reason to reset the camera, if its null though, override the value since it hasnt been instantiated
    if(mapView_.camera == NULL){
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: manager.location.coordinate.latitude
                                                                longitude: manager.location.coordinate.longitude
                                                                     zoom:14];
        mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapView_.myLocationEnabled = YES;
        mapView_.delegate = self;
        self.view = mapView_;
        [self viewDidAppear:NO];

        //ensures the screen is refreshed with the appropriate data
    }

}

//Called when a user taps on the map. Will take the user to a new event page, but already includes the location as coordinates
-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    UIStoryboard * storyboard = self.storyboard;
    if(eventController==nil){
     eventController = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    }
    [self presentViewController:eventController animated:YES completion:nil];
    eventController.location.text= [NSString stringWithFormat:@"%f %f",coordinate.latitude, coordinate.longitude];
    NSLog(@"location:%@", eventController.location.text);

}

//
-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    //If the user taps the popup window for a marker, it will take him to the events page, containing all the info for that marker.
    //If the marker is titles "You Are Here", that is not an event. That is simply the location of the User
    if([marker.title isEqualToString:@"You Are Here"]){
                return;
    }
    UIStoryboard * storyboard = self.storyboard;
    if(eventController==nil){
        eventController = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    }
    [self presentViewController:eventController animated:YES completion:nil];
    [eventController editEvent:marker.userData];
}

#pragma mark CLLocationManagerDelegate Methods

//Called if there is an error capturing the location
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Location Services"
//                                                    message:@"Please enable location services"
//                                                   delegate:self
//                                          cancelButtonTitle:@"Settings"
//                                          otherButtonTitles: nil];
//    [alert show];
//    NSLog(@"Error: %@", error);
//    NSLog(@"Failed to get location! :(");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
}

//Will poll this to capture any changes to the users location
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if(![[locations objectAtIndex:[locations count]-1] isKindOfClass:[CLLocation class]]){
        NSLog(@"could not read users location");
        return;
    }
    CLLocation * currentLocation = [locations objectAtIndex:[locations count]-1];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(error == nil && [placemarks count] > 0){
            placemark = [placemarks lastObject];
        }
        else{
            NSLog(@"%@", error.debugDescription);
        }
    }];
    userLocation = currentLocation;
    [self setupGoogleMap];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    //if(status==YES){
        NSLog(@"Authorization status changed");
    //}
}

@end

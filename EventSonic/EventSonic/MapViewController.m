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
    GMSMapView *mapView_;//the map view object, shows google maps and its markers
    CLGeocoder * geocoder;//converts coordinates to address, and vice versa
    CLPlacemark * placemark;
    CLLocation * userLocation;
}

@synthesize eventCount, events, eventInfo, manager, desiredRadius;
- (void)viewDidLoad {
    [super viewDidLoad];
    if([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied){
        NSLog(@"need location services");
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Location Services"
                                                        message:@"Please enable location services"
                                                       delegate:self
                                              cancelButtonTitle:@"Settings"
                                              otherButtonTitles: nil];
        [alert show];

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

    for(int i =0; i<events.count; i++){
        NSLog(@"%@", ((Event *)[events objectAtIndex:i]).name);
    }
    //Clears all the markers from the map
    [mapView_ clear];
    
    //Will add the users current location as a marker on the map, and then adds markers that are only within a user specified range(default 3) to display on the map
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(manager.location.coordinate.latitude, manager.location.coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"You Are Here";
    marker.map = mapView_;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: manager.location.coordinate.latitude
                                                            longitude: manager.location.coordinate.longitude
                                                                 zoom:14];
    mapView_.camera = camera;
    //will show the markers for the events, shows when, where, and the distance to that event from the users current location
    
    /*
     weird bug, some locations are returning nan as the distanceandbearing miles. Dont know how to fix this yet. gonna begin testing
     */
    for(int i =0; i<events.count; i++){
                Event * event = [events objectAtIndex:i];
        NSArray * latLong = [event.location componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([[latLong objectAtIndex:0] doubleValue], [[latLong objectAtIndex:1] doubleValue]);
        ZFHaversine *distanceAndBearing = [[ZFHaversine alloc] initWithLatitude1:manager.location.coordinate.latitude
                                                                      longitude1:manager.location.coordinate.longitude
                                                                       latitude2:position.latitude
                                                                      longitude2:position.longitude];
        NSLog(@"%f", [distanceAndBearing miles]);
        if([distanceAndBearing miles]<=[desiredRadius doubleValue]){
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            marker.title = event.name;
            marker.map = mapView_;
            marker.userData = event;
            marker.snippet = [NSString stringWithFormat:@"When: %@\nWhere: %@\nDistance: %f miles", event.date, event.details, [distanceAndBearing miles] ];
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
    //uses haversines formula to find the distance around the globe using latitude and longitude of 2 points
    ZFHaversine *distanceAndBearing = [[ZFHaversine alloc] initWithLatitude1:mapView_.myLocation.coordinate.latitude
                                                                  longitude1:mapView_.myLocation.coordinate.longitude
                                                                   latitude2:userLocation.coordinate.latitude
                                                                  longitude2:userLocation.coordinate.longitude];
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
    [self viewDidAppear:NO];

}

//Called when a user taps on the map. Will take the user to a new event page, but already includes the location as coordinates
-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    UIStoryboard * storyboard = self.storyboard;
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    [self presentViewController:vc animated:YES completion:nil];
    vc.location.text = [NSString stringWithFormat:@"%f %f",coordinate.latitude, coordinate.longitude];

}

//
-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    //If the user taps the popup window for a marker, it will take him to the events page, containing all the info for that marker.
    //If the marker is titles "You Are Here", that is not an event. That is simply the location of the User
    if([marker.title isEqualToString:@"You Are Here"]){
                return;
    }
    UIStoryboard * storyboard = self.storyboard;
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    [self presentViewController:vc animated:YES completion:nil];
    [vc editEvent:marker.userData];
}

#pragma mark CLLocationManagerDelegate Methods

//Called if there is an error capturing the location
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Location Services"
                                                    message:@"Please enable location services"
                                                   delegate:self
                                          cancelButtonTitle:@"Settings"
                                          otherButtonTitles: nil];
    [alert show];
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location! :(");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
}

//Will poll this to capture any changes to the users location
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
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
        NSLog(@"this is good");
    //}
}

@end

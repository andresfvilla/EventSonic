//
//  MapViewController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "GPS.h"
#import <CoreLocation/CoreLocation.h>
#import <ZFHaversine/ZFHaversine.h>
#import <CoreData/CoreData.h>
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import "EventsController.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>

//this is for the location of the user
@property(nonatomic, strong) CLLocationManager * manager;
//This is the radius for which markers will appear(distance from the user such that the markers are visible)
@property NSNumber * desiredRadius;
@property int eventCount;//number of events currently being displayed to the user
@property NSArray * events;//the list of events being shown to the user
@property Event * eventInfo;//the information from an event requested by the user
//@property Location userLocation;//users location or the inputted location specified by the user

-(void) click:(UIButton *) b;//used When the user does an action in the map view

@end

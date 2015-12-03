//
//  MapViewController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import "EventsController.h"

/*!
 @class AppDelegate
 Controller class for the MapView
 */
@interface MapViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate, UIAlertViewDelegate>

/*!
 *@brief this is for the location of the user
 */
@property(nonatomic, strong) CLLocationManager * manager;

/*!
 *@brief This is the radius for which markers will appear(distance from the user such that the markers are visible) 
 */
@property NSNumber * desiredRadius;

/*!
 *@brief number of events currently being displayed to the user
 */
@property int eventCount;

/*!
 *@brief the list of events being shown to the user
 */
@property NSArray * events;//

/*!
 *@brief The map view object, shows google maps and its markers
 */
@property GMSMapView *mapView_;

/*!
 *@brief This is the list of markers being shown
 */
@property NSMutableArray * markerList;//


@property(strong)EventsController * eventController;



@end

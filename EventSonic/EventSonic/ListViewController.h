//
//  ListViewController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <CoreData/CoreData.h>
#import <ZFHaversine/ZFHaversine.h>
#import <CoreLocation/CoreLocation.h>
#import "EventsController.h"

@interface ListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UITableView * table;

@property NSMutableArray * name;
@property NSMutableArray * time;

//@property View CurrentView;//we also need to access attributes on the currentView
@property int eventCount;//number of events currently being displayed to the user
@property NSMutableArray * events;//the list of events being shown to the user
@property Event * eventInfo;//the information from an event requested by the user
//@property Location userLocation;//users location or the inputted location specified by the user

-(IBAction)clickNew:(id) sender;//used When the user does an action in the map view

@end

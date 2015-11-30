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
#import <CoreLocation/CoreLocation.h>
#import "EventsController.h"
#import "AppDelegate.h"
#import "MapViewController.h"

@interface ListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UITableView * table;//The table that is presented on the view
@property int eventCount;//number of events currently being displayed to the user
@property NSArray * events;//the list of events being shown to the user
@property Event * eventInfo;//the information from an event requested by the user
@property NSMutableArray * tableData;//the list of events being shown

//core data properties
@property(nonatomic, readonly) NSManagedObjectContext * managedObjectContext;


-(IBAction)clickNew:(id) sender;//used When the user does an action in the map view

@end

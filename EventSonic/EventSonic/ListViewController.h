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

/*!
 @class AppDelegate
 Controller class for the MapView
 */
@interface ListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

/*!
 * @brief This is the table that is presented on the view
 */
@property IBOutlet UITableView * table;//The table that is presented on the view

/*!
 * @brief This is the number of events currently being displayed to the user
 */
@property int eventCount;//number of events currently being displayed to the user

/*!
 * @brief This is an array containing the events being shown to the user
 */
@property NSArray * events;//the list of events being shown to the user

/*!
 * @brief This is the information from an event requested by the user
 */
@property Event * eventInfo;//the information from an event requested by the user

/*!
 * @brief The list of events being shownin the tableView
 */
@property NSMutableArray * tableData;//the list of events being shown

/*!
 * @brief This manages the collections of managedObjects in core data
 */
@property(nonatomic, readonly) NSManagedObjectContext * managedObjectContext;

/*!
 * @brief This is used to detect touches in the map view
 */
-(IBAction)clickNew:(id) sender;//used When the user does an action in the map view

@end

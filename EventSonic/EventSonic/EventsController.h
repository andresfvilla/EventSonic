//
//  EventsController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Event.h"
#import "AppDelegate.h"
#import "AccountController.h"
#import <Google/SignIn.h>

/*!
 @class AppDelegate
 Controller class for the event detail view
 */
@interface EventsController : UIViewController


/*!
 * @brief This is a textfield for the name of the event
 */
@property IBOutlet UITextField * name;//The name text field

/*!
 * @brief This is a textfield for the date of the event
 */
@property IBOutlet UITextField * date;//the date text field

/*!
 * @brief This is a textfield for the location coordinates of the event
 */
@property IBOutlet UITextField * location;//the location text field

/*!
 * @brief This is a textfield for the details of the event
 */
@property IBOutlet UITextField * details;//the details text field

/*!
 * @brief This is a Label for the ownder of the event
 */
@property IBOutlet UILabel * owner;//Cannot be modified by the user

/*!
 * @brief This is a Label for the rating of the event
 */
@property IBOutlet UILabel * rating;//Cannot be modified by the use


@property NSArray * events;//the list of events returned from a fetch request

/*!
 * @brief This manages the collections of managedObjects in core data
 */
@property NSManagedObjectContext * managedObjectContext;//the context for coredata, manages the ojects stored


/*!
 * @brief This is used for dismissing the current view once the back button has been clicked
 */
- (IBAction)clickBack:(id)sender;//called when the back button is clicked, dismisses the current view

/*!
 * @brief This is used for saving with core data once the save button has been clicked
 */
- (IBAction)clickSave:(id)sender;//used to save a new object to CoreData

/*!
 * @brief This is used for dismissing the current view once the back button has been clicked
 * @param event An event object to be edited
 */
- (IBAction)editEvent:(Event *) event;//used when the user decides to modify or update an event

/*!
 * @brief This is Searches to ensure that the location is entered properly
 * @param location validates the location coordinates
 * @discussion It is recommended to use the map view to create events
 */
//
-(BOOL)validatelocation:(NSString *)location;


/*!
 * @brief This is ued to ensure no existing event has the same name as the new event 
 * @param name The name of the event
 */
-(BOOL)validateName:(NSString *) name;

@end

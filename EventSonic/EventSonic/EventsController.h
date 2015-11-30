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

@interface EventsController : UIViewController

@property IBOutlet UITextField * name;//The name text field
@property IBOutlet UITextField * date;//the date text field
@property IBOutlet UITextField * location;//the location text field
@property IBOutlet UITextField * details;//the details text field
@property IBOutlet UILabel * owner;//Cannot be modified by the user
@property IBOutlet UILabel * rating;//Cannot be modified by the use

//talking with core data
@property NSArray * events;//the list of events returned from a fetch request
@property NSManagedObjectContext * managedObjectContext;//the context for coredata, manages the ojects stored

- (IBAction)clickBack:(id)sender;//called when the back button is clicked, dismisses the current view
- (IBAction)clickSave:(id)sender;//used to save a new object to CoreData
- (IBAction)editEvent:(Event *) event;//used when the user decides to modify or update an event

//Searches to ensure that the location is entered properly(Recommended to use the map view to create events)
-(BOOL)validatelocation:(NSString *)location;

//Searches to ensure no event containt the same name as the new event
-(BOOL)validateName:(NSString *) name;

@end

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

@property UIViewController * callingView;//will send the user back to the viewcontroller that called this event

@property IBOutlet UITextField * name;
@property IBOutlet UITextField * date;
@property IBOutlet UITextField * location;
@property IBOutlet UITextField * details;
@property IBOutlet UILabel * owner;//Cannot be modified
@property IBOutlet UILabel * rating;//Cannot be modified

//talking with core data
@property NSArray * events;
@property NSManagedObjectContext * managedObjectContext;

- (IBAction)clickBack:(id)sender;
- (IBAction)clickSave:(id)sender;
- (IBAction)editEvent:(Event *) event;

@end

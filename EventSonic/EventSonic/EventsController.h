//
//  EventsController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsController : UIViewController

@property UIViewController * callingView;//will send the user back to the viewcontroller that called this event

@property IBOutlet UITextField * name;
@property IBOutlet UITextField * date;
@property IBOutlet UITextField * location;
@property IBOutlet UITextField * details;
@property IBOutlet UILabel * Owner;//Cannot be modified
@property IBOutlet UILabel * Rating;//Cannot be modified


- (IBAction)clickBack:(id)sender;

@end

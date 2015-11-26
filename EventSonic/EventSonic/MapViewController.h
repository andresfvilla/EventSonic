//
//  MapViewController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController

@property int eventCount;//number of events currently being displayed to the user
@property List<Events> events;//the list of events being shown to the user
@property Event * eventInfo;//the information from an event requested by the user

-(void) click:(UIButton *) b;//used When the user does an action in the map view

@end

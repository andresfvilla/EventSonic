//
//  ListViewController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Events.h"
@interface ListViewController : UIViewController

//@property View CurrentView;//we also need to access attributes on the currentView
@property int eventCount;//number of events currently being displayed to the user
@property NSMutableArray * events;//the list of events being shown to the user
@property Events * eventInfo;//the information from an event requested by the user
//@property Location userLocation;//users location or the inputted location specified by the user

-(void) click:(UIButton *) b;//used When the user does an action in the map view

@end

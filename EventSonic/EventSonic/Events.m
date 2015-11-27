//
//  Events.m
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import "Events.h"


@implementation Events

@synthesize name, time, rating, location;
-(id)init{
    return self;
}

-(BOOL)createEvent: (Events *) e{
    return YES;
}


-(Events *)getEventsInfo: (Events *) e{
    return [[Events alloc] init];
}

//-(Events *)eventsAt:(CLLocation *) loc{
//    //do some stuff to return the events at that specified location
//}

@end

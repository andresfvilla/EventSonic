//
//  GPS.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <ZFHaversine.h>

//Is this class even necessary, i believe IOS has a built in class to manage GPS related things
@interface GPS : NSObject
//I still dont know if this object is necessary, we may be able to parse from a string for location
//@property Location loc;//contaisn the latest location of the user

//Dont know if this is needed
//-(Location *)getLocation;//Used when user requests events in an area, will return the users locations

@end

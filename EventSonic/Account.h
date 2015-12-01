//
//  Account.h
//  EventSonic
//
//  Created by Andres Villa on 11/30/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * deviceid;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * userkey;
@property (nonatomic, retain) NSSet *eventsOwned;
@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addEventsOwnedObject:(Event *)value;
- (void)removeEventsOwnedObject:(Event *)value;
- (void)addEventsOwned:(NSSet *)values;
- (void)removeEventsOwned:(NSSet *)values;

@end

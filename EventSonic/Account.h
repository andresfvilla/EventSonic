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


/*!
 @class Account
 Class which receives notifcations when the UIApplication object reaches certain states.
 */@interface Account : NSManagedObject


/*!
 * @brief This is used to store the currentUser deviceID
 */
@property (nonatomic, retain) NSString * deviceid;

/*!
 * @brief This is used to store the currentUser username
 */
@property (nonatomic, retain) NSString * username;

/*!
 * @brief This is used to store the currentUser userkey
 */
@property (nonatomic, retain) NSString * userkey;

/*!
 * @brief This is used to store the currentUser events
 */
@property (nonatomic, retain) NSSet *eventsOwned;
@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addEventsOwnedObject:(Event *)value;

- (void)removeEventsOwnedObject:(Event *)value;

- (void)addEventsOwned:(NSSet *)values;

- (void)removeEventsOwned:(NSSet *)values;

@end

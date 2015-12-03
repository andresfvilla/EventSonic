//
//  AppDelegate.h
//  EventSonic
//
//  Created by Andres Villa on 11/25/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//
// Alex was here

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Google/SignIn.h"

/*!
 @class AppDelegate
Class which receives notifcations when the UIApplication object reaches certain states.
*/

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>


/*!
 *  @brief window to use when presenting storyboard
 */
@property (strong, nonatomic) UIWindow *window;

/*!
 *  @brief This is used to manage collections of managedObjects
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/*!
 *  @brief window to use when presenting storyboard
 */
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

/*!
 *  @brief This is used to manage persistent object stores
 */
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end


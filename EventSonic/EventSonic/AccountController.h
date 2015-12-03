//
//  AccountController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Google/SignIn.h>
#import "AppDelegate.h"
#import "Account.h"

/*!
 @class AppDelegate
 Controller class for the account view
 */
@interface AccountController : UIViewController <GIDSignInUIDelegate>
// [END viewcontroller_interfaces]

// [START viewcontroller_vars]

/*!
 * @brief The signInButton IBOutlet connection
 */
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;

/*!
 * @brief The signOutButton IBOutlet connection
 */
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

//not used
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;

/*!
 * @brief label for statusText
 */
@property (weak, nonatomic) IBOutlet UILabel *statusText;

/*!
 * @brief The signInButton IBOutlet connection
 */
@property NSString * currentUser;//the current users name "Alex Henao"

/*!
 * @brief The unique for the currentUser
 */
@property NSString * currentUserKey;//the current users hash value from google api
// [END viewcontroller_vars]

/*!
 * @brief The label for welcome text
 */
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

/*!
 * @brief The connection for the profile picture image
 */
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

/*!
 * @brief This manages the collection of managedObjects
 */
-(NSManagedObjectContext *)managedObjectContext;

/*!
 * @brief This is called when the Sign Out button is clicked
 */
- (IBAction)didTapSignOut:(id)sender;


- (IBAction)didTapDisconnect:(id)sender;

/*!
 * @brief This verifies that the deviceId is matches that of the currentUser
 */
-(void)verifyDeviceID;


@end
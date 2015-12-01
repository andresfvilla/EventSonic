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

// [START viewcontroller_interfaces]
@interface AccountController : UIViewController <GIDSignInUIDelegate>
// [END viewcontroller_interfaces]

// [START viewcontroller_vars]
@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@property (weak, nonatomic) IBOutlet UILabel *statusText;
// [END viewcontroller_vars]
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@end
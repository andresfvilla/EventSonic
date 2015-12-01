//
//  AccountController.m
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import "AccountController.h"


@implementation AccountController

// [START viewdidload]
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO(developer) Configure the sign-in button look/feel
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    // [START_EXCLUDE silent]
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(receiveToggleAuthUINotification:)
     name:@"ToggleAuthUINotification"
     object:nil];
    
    [self toggleAuthUI];
    [self statusText].text = @"Google Sign in\niOS Demo";
    // [END_EXCLUDE]
}
// [END viewdidload]

// Signs the user out of the application for scenarios such as switching
// profiles.
// [START signout_tapped]
- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    // [START_EXCLUDE silent]
    [self toggleAuthUI];
    // [END_EXCLUDE]
}
// [END signout_tapped]

// Note: Disconnect revokes access to user data and should only be called in
//     scenarios such as when the user deletes their account. More information
//     on revocation can be found here: https://goo.gl/Gx7oEG.
// [START disconnect_tapped]
- (IBAction)didTapDisconnect:(id)sender {
    [[GIDSignIn sharedInstance] disconnect];
}
// [END disconnect_tapped]

// [START toggle_auth]
- (void)toggleAuthUI {
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil) {
        // Not signed in
        [self statusText].text = @"Google Sign in\niOS Demo";
        self.welcomeLabel.text = [NSString stringWithFormat:@"Sign in stranger"];
        self.signInButton.hidden = NO;
        self.signOutButton.hidden = YES;
        self.profilePic.hidden = YES;
    } else {
        // Signed in
        self.signInButton.hidden = YES;
        self.signOutButton.hidden = NO;
        self.currentUser = [NSString stringWithFormat:@"Welcome %@",[GIDSignIn sharedInstance].currentUser.profile.name];
        self.currentUserKey = [NSString stringWithFormat:@"Welcome %@",[GIDSignIn sharedInstance].currentUser.authentication.idToken];
        NSURL *profilePicURL = [[[GIDSignIn sharedInstance].currentUser profile]imageURLWithDimension:175];
        self.profilePic.image =[UIImage imageWithData: [NSData dataWithContentsOfURL:profilePicURL]];
        self.profilePic.hidden = NO;
        self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome %@",[GIDSignIn sharedInstance].currentUser.profile.name];
        [self verifyDeviceID];
    }
}
// [END toggle_auth]

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"ToggleAuthUINotification"
     object:nil];
    
}

- (void) receiveToggleAuthUINotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"ToggleAuthUINotification"]) {
        [self toggleAuthUI];
        self.statusText.text = [notification userInfo][@"statusText"];
    }
}

-(NSManagedObjectContext *)managedObjectContext{
    //finds the applications appdelegate, casts it to the type of our appdelegate and then it will find the managedobjectcontext
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

-(void)verifyDeviceID{
    
    NSString * identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES]];
    NSArray * arr = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    NSMutableArray * array = [[NSMutableArray alloc] initWithArray:arr];
    for(int i =0; i<array.count; i++){
        if([((Account *)[array objectAtIndex:i]).username isEqualToString:[GIDSignIn sharedInstance].currentUser.profile.name] && ![identifier isEqualToString:((Account *)[array objectAtIndex:i]).deviceid]){
            NSLog(@"mismatch id's, send the email");
            [self didTapSignOut:nil];
            return;
        }
    }
    
    Account * newAccount = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:self.managedObjectContext];
    newAccount.userkey =[GIDSignIn sharedInstance].currentUser.authentication.idToken;
    newAccount.username = [GIDSignIn sharedInstance].currentUser.profile.name;
    newAccount.deviceid = identifier;
    [array addObject:newAccount];
    arr = [NSArray arrayWithArray:array];
    [self.managedObjectContext save:nil];
    
    NSLog(@"%@",newAccount.deviceid);
    /*
     fetchRequest
     array = [fetchrequest execut];
     for(all elements in array){
        if(element.uniqueHash == currentUserHash){
            deviceID = [stack overflow];
            if(element.deviceID != deviceID){
                    kick him off, and send a verification email. This will update the deviceID;
     
     }
        }
     }
     */
}
@end

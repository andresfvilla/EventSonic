//
//  AccountController.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AccountController : UITableViewController

@property NSString * username;

-(void) click:(UIButton *) b;//used for when the user presses a button. Processes info like logging in and user settings
@end

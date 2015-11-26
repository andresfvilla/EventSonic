//
//  AccountInfo.h
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Events.h"
@interface AccountInfo : NSObject

//favorites isnt a use case that is supposed to be implemented
//@property favorites;//The user's list of favorites
-(BOOL)login:(NSString *) username password: (NSString *) password;
-(NSMutableArray *)favorites:(NSString *)username;
-(BOOL)addFavorite: (Events *) e;

@end

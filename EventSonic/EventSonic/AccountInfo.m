//
//  AccountInfo.m
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import "AccountInfo.h"

@implementation AccountInfo

-(BOOL)login:(NSString *) username password: (NSString *) password{
    return YES;
}

-(NSMutableArray *)favorites:(NSString *)username{
    return [[NSMutableArray alloc] init];
}

-(BOOL)addFavorite: (Event *) e{
    return YES;
}

@end

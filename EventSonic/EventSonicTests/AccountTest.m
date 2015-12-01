//
//  AccountTest.m
//  EventSonic
//
//  Created by Andres Villa on 11/28/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AccountController.h"
#import <Google/SignIn.h>
#import "AppDelegate.h"

@interface AccountTest : XCTestCase

@end

@implementation AccountTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testAuthUI{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountController * vc = [storyboard instantiateViewControllerWithIdentifier:@"accountView"];
    vc.view.hidden = NO;//this will call view did load, should not auto sign in
    
    XCTAssertEqual(vc.signInButton.hidden, NO);
    XCTAssertEqual(vc.signOutButton.hidden, YES);
    XCTAssertEqual(vc.profilePic.hidden, YES);
}

@end

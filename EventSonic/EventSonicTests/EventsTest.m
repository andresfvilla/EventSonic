//
//  EventsTest.m
//  EventSonic
//
//  Created by Andres Villa on 11/28/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EventsController.h"
#import "Event.h"

@interface EventsTest : XCTestCase

@end

@implementation EventsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}


//-------viewDidLoad


//-------editEvent
-(void)testEventEdit{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    vc.view.hidden = NO;
    //[vc viewDidAppear:NO];
    Event * newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:vc.managedObjectContext];;
    newEvent.name = @"test";
    newEvent.date = @"test";
    newEvent.location = @"1 1";
    newEvent.details = @"test";
    [vc editEvent:newEvent];
    XCTAssertEqualObjects(newEvent.name, vc.name.text);
    XCTAssertEqualObjects(newEvent.date, vc.date.text);
    XCTAssertEqualObjects(newEvent.location, vc.location.text);
    XCTAssertEqualObjects(newEvent.details, vc.details.text);
}


-(void)testEventSaveWithBadCoordinates{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    vc.view.hidden = NO;
    //[vc viewDidAppear:NO];
    Event * newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:vc.managedObjectContext];;
    newEvent.name = @"test";
    newEvent.date = @"test";
    newEvent.location = @"200 200";
    newEvent.details = @"test";
    [vc editEvent:newEvent];
    
    [vc clickSave:nil];
    Class UIAlertManager = objc_getClass("_UIAlertManager");
    UIAlertView *topMostAlert = [UIAlertManager performSelector:@selector(topMostAlert)];
    NSLog(@"Title of Alert:%@",topMostAlert.title);
}


//--------clickBack

//--------clickSave



//-------textFieldShouldReturn


//--------touchesbegan with event

@end

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
    //Expecting vc.<text>.<fields> has the same data from the event
    XCTAssertEqualObjects(newEvent.name, vc.name.text);
    XCTAssertEqualObjects(newEvent.date, vc.date.text);
    XCTAssertEqualObjects(newEvent.location, vc.location.text);
    XCTAssertEqualObjects(newEvent.details, vc.details.text);
}


//--------validateName
-(void)testNameValidation{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    vc.view.hidden = NO;
    
    BOOL valid = [vc validateName:@"testName"];
    XCTAssert(valid, @"expected to be valid");
}

-(void)testBadLocationValidation{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    vc.view.hidden = NO;
    
    BOOL valid = [vc validatelocation:@"1, 2"];
    XCTAssert(!valid, @"expected to be invalid");
}

@end

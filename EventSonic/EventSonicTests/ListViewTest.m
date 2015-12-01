//
//  ListViewTest.m
//  EventSonic
//
//  Created by Andres Villa on 11/28/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ListViewController.h"
#import "Event.h"

@interface ListViewTest : XCTestCase

@end

@implementation ListViewTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


//------clickNew
-(void)testNewEvent{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"listView"];
    vc.view.hidden = NO;
    
    [vc clickNew:nil];
    
    MapViewController * mapvc = [vc.tabBarController.viewControllers objectAtIndex:0];
    XCTAssertEqual(mapvc.eventController.view.hidden, NO);
    
    
}


//if one object exists, should only have 1 row to populate
-(void)testNumberOfRows{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"listView"];
    vc.view.hidden = NO;
    vc.tableData = [[NSMutableArray alloc] init];
    Event * newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:vc.managedObjectContext];;
    newEvent.name = @"test";
    newEvent.date = @"test";
    newEvent.location = @"1 1";
    newEvent.details = @"test";
    [vc.tableData addObject:newEvent];
    
    NSInteger rows = [vc tableView:vc.tableView numberOfRowsInSection:1];
    XCTAssertEqual(rows, 1);
}

//----tableview cellforrowatindexpath
-(void)testTableCellsShowingEvent{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"listView"];
    vc.view.hidden = NO;
    
    vc.tableData = [[NSMutableArray alloc] init];
    Event * newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:vc.managedObjectContext];;
    newEvent.name = @"test";
    newEvent.date = @"test";
    newEvent.location = @"1 1";
    newEvent.details = @"test";
    [vc.tableData addObject:newEvent];
    
    Event * event = [vc tableView:vc.tableView cellForRowAtIndexPath:0];
    NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:1];
    [vc tableView:vc.tableView didSelectRowAtIndexPath:path];
    
    MapViewController * mapvc = [vc.tabBarController.viewControllers objectAtIndex:0];

    XCTAssertEqual(mapvc.eventController.view.hidden, NO);
}

-(void)testBadClickOnCell{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"listView"];
    vc.view.hidden = NO;
    
    NSIndexPath * path = [NSIndexPath indexPathForRow:2 inSection:1];
    Event * event = (Event *)[vc tableView:vc.tableView cellForRowAtIndexPath:path];
    XCTAssertEqualObjects(event, nil);
}


@end

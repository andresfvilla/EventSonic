//
//  MapViewTest.m
//  EventSonic
//
//  Created by Andres Villa on 11/28/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MapViewController.h"

@interface MapViewTest : XCTestCase

@end

@implementation MapViewTest

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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
//----------ViewDidLoad
-(void)testViewLoad{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MapViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"mapView"];
    vc.view.hidden = NO;
    
    XCTAssertNotNil(vc, @"View controller should not be nil");
}

//----------ViewDidAppear



//----------ManagedObjectContext


//----------setupGoogleMap



//----------mapView didTapAtCoordinate



//----------mapView didTapInfoWindowOfMarker


//----------locationManager did Fail With Error


//----------alerView clickedButtonAtIndex

//----------locationmanager didupdatelocations


//----------locationmanaer didchangeauthorizationstatus


@end

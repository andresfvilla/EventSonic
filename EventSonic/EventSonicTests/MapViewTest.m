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
#import "EventsController.h"

@interface MapViewTest : XCTestCase

@end

@implementation MapViewTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [GMSServices provideAPIKey:@"AIzaSyCptcXEIK3QAxhyvYGPYUWuUoyvdZEb9kw"];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//----------ViewDidLoad
-(void)testViewLoad{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"mapView"];
    vc.view.hidden = NO;
    
    XCTAssertNotNil(vc, @"View controller should not be nil");
}

//----------ViewDidAppear

-(void)testViewAppearing{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"mapView"];
    vc.view.hidden = NO;
    [vc viewDidAppear:NO];
    GMSMarker *marker = nil;

    for(int i =0; i<vc.markerList.count;i++){
        if([((GMSMarker *)[vc.markerList objectAtIndex:i]).title isEqualToString:@"You Are Here"]){
            marker =(GMSMarker *)[vc.markerList objectAtIndex:i];
        }
    }
    XCTAssertNotNil(marker, @"User marker should exist");

}

//----------ManagedObjectContext


//----------setupGoogleMap
-(void)testGoogleMap{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"mapView"];
    vc.view.hidden = NO;
    
}


//----------mapView didTapAtCoordinate
-(void)testTapOnMap{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"mapView"];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: 0
                                                            longitude: 0
                                                                 zoom:14];
    GMSMapView *testMapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    testMapView_.myLocationEnabled = YES;
    testMapView_.delegate = vc;
    vc.view = testMapView_;
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(15, 15);
    [vc mapView: testMapView_ didTapAtCoordinate:position];
    NSString * expected = [NSString stringWithFormat:@"%f %f", position.latitude, position.longitude];
    XCTAssertEqualObjects(vc.eventController.location.text, expected);
}


//----------locationManager did Fail With Error


//----------alerView clickedButtonAtIndex

//----------locationmanager didupdatelocations
-(void)testUpdateLocations{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"mapView"];
    vc.view.hidden = NO;
    [vc viewDidAppear:NO];
    [vc locationManager:vc.manager didUpdateLocations:[[NSArray alloc] initWithObjects:@"not a location", nil]];
    //ensures that no exception is thrown, and no state is changed
}

//----------locationmanaer didchangeauthorizationstatus


@end

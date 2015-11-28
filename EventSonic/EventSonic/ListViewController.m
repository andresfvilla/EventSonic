//
//  ListViewController.m
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController{
    CLGeocoder * geocoder;
    CLPlacemark * placemark;
    CLLocation * userLocation;
}

@synthesize events, table;
- (void)viewDidLoad {
    NSLog(@"loaded the view");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"did this");
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    self.events = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
//    NSMutableArray * array = [NSMutableArray arrayWithArray:events];
//    MapViewController * map = [self.storyboard instantiateViewControllerWithIdentifier:@"mapView"];
//    for(int i =0; i<self.events.count; i++){
//        Event * e = [events objectAtIndex:i];
//        NSArray * latLong = [e.location componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([[latLong objectAtIndex:0] doubleValue], [[latLong objectAtIndex:1] doubleValue]);
//        
//        ZFHaversine *distanceAndBearing = [[ZFHaversine alloc] initWithLatitude1:map.manager.location.coordinate.latitude
//                                                                      longitude1:map.manager.location.coordinate.longitude
//                                                                       latitude2:position.latitude
//                                                                      longitude2:position.longitude];
//        
//        MapViewController * map = [self.storyboard instantiateViewControllerWithIdentifier:@"mapView"];
//        if([distanceAndBearing miles]>=[map.desiredRadius doubleValue]){
//            NSLog(@"%@", e.name);
//            [array removeObjectIdenticalTo:e];
//        }
//    }
//    events = [array copy];
    NSLog(@"view appeared");
//    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
//    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
//    
//    self.events = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    //self.events = nil;
    [table reloadData];
}
-(NSManagedObjectContext *)managedObjectContext{
    //finds the applications appdelegate, casts it to the type of our appdelegate and then it will find the managedobjectcontext
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickNew:(id)sender{
    UIStoryboard * storyboard = self.storyboard;
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    [self presentViewController:vc animated:YES completion:nil];
    events = vc.events;
}

//Table view delegate methods
#pragma mark - Table View data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.events.count;//this needs to be revisited, should be equal to the number of events in the coredata
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"MainCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //Event * eventList = [self.events objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    Event * eventList = [self.events objectAtIndex:indexPath.row];

    cell.textLabel.text = eventList.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected a specific row");
    UIStoryboard * storyboard = self.storyboard;
    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
    NSLog(@"%@",[events objectAtIndex:indexPath.row]);
    [self presentViewController:vc animated:YES completion:nil];
    [vc editEvent:[events objectAtIndex:indexPath.row]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end

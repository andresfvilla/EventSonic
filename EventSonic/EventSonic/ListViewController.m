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

@synthesize events, table, tableData;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    tableData = [[NSMutableArray alloc] init];
    self.events = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    MapViewController * mapvc = [self.tabBarController.viewControllers objectAtIndex:0];

    for(int i =0; i<events.count; i++){
        Event * event = [events objectAtIndex:i];
        NSArray * latLong = [event.location componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        CLLocation * position = [[CLLocation alloc] initWithLatitude:[[latLong objectAtIndex:0] doubleValue] longitude:[[latLong objectAtIndex:1] doubleValue]];
        
        if(([position distanceFromLocation:mapvc.manager.location]/1609.34)<=[mapvc.desiredRadius doubleValue]){
            [tableData addObject:event];
        }
    }
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
    MapViewController * mapvc = [self.tabBarController.viewControllers objectAtIndex:0];
    EventsController * eventController = mapvc.eventController;
    if(eventController==nil){
        eventController = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
        mapvc.eventController = eventController;
    }
    [self presentViewController:eventController animated:YES completion:nil];
    events = mapvc.events;
}

//Table view delegate methods
#pragma mark - Table View data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return tableData.count;//this needs to be revisited, should be equal to the number of events in the coredata
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>=tableData.count || indexPath.row<0){
        return nil;
    }
    static NSString * CellIdentifier = @"MainCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Event * eventList = [self.tableData objectAtIndex:indexPath.row];

    cell.textLabel.text = eventList.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard * storyboard = self.storyboard;
    
    MapViewController * mapvc = [self.tabBarController.viewControllers objectAtIndex:0];
    EventsController * vc = mapvc.eventController;
    if(vc==nil){
        vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
        mapvc.eventController = vc;
    }
    
    NSLog(@"%@",[events objectAtIndex:indexPath.row]);
    [self presentViewController:vc animated:YES completion:nil];
    [vc editEvent:[events objectAtIndex:indexPath.row]];
}
@end

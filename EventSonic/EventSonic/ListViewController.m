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

@implementation ListViewController

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

    
//    for(int i =0; i<events.count; i++){
//        NSLog(@"Event:%@", ((Event *)[events objectAtIndex:i]).name);
//    }
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
    vc.callingView = self;
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
    for(int i =0; i<events.count; i++){
        NSLog(@"Event:%@", ((Event *)[events objectAtIndex:i]).name);
    }
    //NSLog(@"searching for a cell");
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
    vc.callingView = self;
    [vc editEvent:[events objectAtIndex:indexPath.row]];
    [self presentViewController:vc animated:YES completion:nil];
    
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

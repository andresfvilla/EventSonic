//
//  EventsController.m
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import "EventsController.h"

@interface EventsController ()

@end

@implementation EventsController

@synthesize callingView, name, date, location, details, events, owner, rating;
- (void)viewDidLoad {
    [super viewDidLoad];

    //TODO: load lists
    //this is basically a query in object form
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.events = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
 
    //this would then tell it to reload the table views data, can be called when returning from the ding dong
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) editEvent:(Event *) event{
    NSLog(@"this will be called when a row is selected");
    NSLog(@"%@", event.name);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)clickBack:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickSave:(id)sender{
    
    NSLog(@"Saving the event to memory");//this should appear now on the map and the list if its in the area
    if()
    Event * newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    
    newEvent.name = name.text;
    newEvent.date = date.text;
    newEvent.location = location.text;
    newEvent.owner = @"YOU";
    newEvent.rating = 0;
    
    [self.managedObjectContext save:nil];
    
    //if system clock changes this will fail
    self.events = [self.events arrayByAddingObject:newEvent];
    
//    for(int i =0; i<events.count; i++){
//        NSLog(@"EventController: %@", ((Event *)[events objectAtIndex:i]).name);
//    }
    
     //[self.tableView reloadData];
    
}

-(NSManagedObjectContext *)managedObjectContext{
    
    //finds the applications appdelegate, casts it to the type of our appdelegate and then it will find the managedobjectcontext
    return [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}
//Handles all the text field protocols
//removes the keyboard if return is pressed
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [name resignFirstResponder];
    [date resignFirstResponder];
    [location resignFirstResponder];
    [details resignFirstResponder];
    
    return TRUE;
}

//gets rid of the keyboard if clicking on whitespace
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [name resignFirstResponder];
    [date resignFirstResponder];
    [location resignFirstResponder];
    [details resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];
}
@end

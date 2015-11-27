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
    
    NSError * error = nil;
    self.events = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(error !=nil){
        NSLog(@"problem with my fetch request");
    }
    //this would then tell it to reload the table views data, can be called when returning from the ding dong
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addEvent:(id)sender{
    Event * eventsList = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];

    eventsList.name = name.text;
    eventsList.date = date.text;
    eventsList.location = location.text;
    eventsList.owner = @"YOU";
    eventsList.rating = 0;
    
    [self.managedObjectContext save:nil];
    
    
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
    //NSLog(@"%@", callingView);
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickSave:(id)sender{
    NSLog(@"Saving the event to memory");//this should appear now on the map and the list if its in the area
    
    Event * eventsList = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    
    eventsList.name = name.text;
    eventsList.date = date.text;
    eventsList.location = location.text;
    eventsList.owner = @"YOU";
    eventsList.rating = 0;
    
    NSLog(@"%@, %@", callingView, callingView.title);
    [self.managedObjectContext save:nil];
    
    self.events = [self.events arrayByAddingObject:eventsList];

//    NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:self.lists.count-1 inSection:0];
//    [self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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

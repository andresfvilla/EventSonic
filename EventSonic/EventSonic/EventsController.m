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

@implementation EventsController{
    BOOL editing;
    Event * updatingEvent;
}

@synthesize callingView, name, date, location, details, events, owner, rating;
- (void)viewDidLoad {
    [super viewDidLoad];
    editing = false;
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
    name.text = event.name;
    date.text = event.date;
    location.text = event.location;
    owner.text = event.owner;
    rating.text = [NSString stringWithFormat:@"%@",event.rating];
    details.text = event.details;
    updatingEvent = event;
    name.enabled = NO;
    editing = YES;
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

    //if updating an existing event. will delete the current instance of the object in order to prevent duplicates in core data
    if(editing){
        [self.managedObjectContext deleteObject:updatingEvent];
    }
    
    //Will fetch all the Events objects in Core Data and sort them by name
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    

    
    //Searches to ensure no event containt the same name as the new event
    NSArray * arr = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        for(int i =0; i<arr.count; i++){
            Event * e = [arr objectAtIndex:i];
            if([[e.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:[name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Name already exist"
                                                                message:@"An event with that name already exists, please choose a unique name"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
                return;
            }
        }
    
    //Searches to ensure that the location is entered properly(Recommended to use the map view to create events)
    NSArray * locVerify = [location.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSNumberFormatter * stringToNum = [[NSNumberFormatter alloc] init];
    if(locVerify.count!=2 || [stringToNum numberFromString:[locVerify objectAtIndex:0]]==nil || [stringToNum numberFromString:[locVerify objectAtIndex:1]]==nil){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Bad Location"
                                                        message:@"Please enter coordinates as latitude and longitude separated by spaces (decimal values). Or tap on the Map View to instantly fill out coordinates"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }

    //
    Event * newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [self.managedObjectContext save:nil];
    newEvent.name = name.text;
    newEvent.date = date.text;
    newEvent.location = location.text;
    newEvent.owner = owner.text;
    newEvent.rating = rating.text;
    newEvent.details = details.text;
    //we need an owned by field to be set
    //arr = [[NSArray alloc] init];
    editing=NO;
    name.enabled = YES;
    [self.managedObjectContext save:nil];
    
    //if system clock changes this will fail????
    self.events = [self.events arrayByAddingObject:newEvent];

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
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

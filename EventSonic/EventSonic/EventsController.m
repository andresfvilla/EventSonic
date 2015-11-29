//
//  EventsController.m
//  EventSonic
//
//  Created by Andres Villa on 11/26/15.
//  Copyright (c) 2015 Andres Villa. All rights reserved.
//

#import "EventsController.h"

@implementation EventsController{
    BOOL editing;//Used to know if the event being saved is an existing one that is updated
    Event * updatingEvent;//The event info that is stored in the coreData that is being updated
    EventsController * instance_;
}

@synthesize name, date, location, details, events, owner, rating;

- (void)viewDidLoad {
    [super viewDidLoad];
    editing = false;//Ensures that if an event is being made, editing is initialized to false
    
    //this is basically a query in object form
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];//Prepares a fetch for the Event entity in CoreData
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];//Will have the lists sorted when fetching
    self.events = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];//populates the events list 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) editEvent:(Event *) event{
    //Will prepare the text fields with the data stored in event
    name.text = event.name;
    date.text = event.date;
    location.text = event.location;
    owner.text = event.owner;
    rating.text = [NSString stringWithFormat:@"%@",event.rating];
    details.text = event.details;
    updatingEvent = event;
    name.enabled = NO;//will ensure that the name of the event cannot be changed
    editing = YES;//Allows the clicksave method to know the event is only being updated, and is not a new one
}

//Will dismiss the event view from the screen
- (IBAction)clickBack:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    name.text = @"";
    date.text = @"";
    location.text = @"";
    owner.text = @"";
    rating.text = @"";
    details.text = @"";
}

- (IBAction)clickSave:(id)sender{
    if([[name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:[@"" stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
        
        editing=NO;
        name.enabled = YES;
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Please enter a name"
                                                        message:@"Please enter a valid name, must include at least 1 character/symbol"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
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
    if(locVerify.count!=2
       || [stringToNum numberFromString:[locVerify objectAtIndex:0]]==nil
       || ([[stringToNum numberFromString:[locVerify objectAtIndex:0]] intValue]>180
           || [[stringToNum numberFromString:[locVerify objectAtIndex:0]] intValue]<-180)
       || [stringToNum numberFromString:[locVerify objectAtIndex:1]]==nil
       || ([[stringToNum numberFromString:[locVerify objectAtIndex:1]] intValue]>180
           || [[stringToNum numberFromString:[locVerify objectAtIndex:1]] intValue]<-180)){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Bad Location"
                                                        message:@"Please enter coordinates as latitude and longitude separated by spaces (decimal values, and -180<=x<=180). Or tap on the Map View to instantly fill out coordinates"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }

    //creates the object that will be stored
    Event * newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [self.managedObjectContext save:nil];
    newEvent.name = name.text;
    newEvent.date = date.text;
    newEvent.location = location.text;
    newEvent.owner = owner.text;
    newEvent.rating = rating.text;
    newEvent.details = details.text;
    //**we need the ownedby field to be set**
    
    //This will alow the name text field to be edited once again, and will ensure that no event is currently being edited
    editing=NO;
    name.enabled = YES;
    
    //updates coreData with the changes that occurred
    [self.managedObjectContext save:nil];
    
    //if system clock changes this will fail????
    self.events = [self.events arrayByAddingObject:newEvent];

    //Dismisses the events view controller
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    name.text = @"";
    date.text = @"";
    location.text = @"";
    owner.text = @"";
    rating.text = @"";
    details.text = @"";
    
}

-(NSManagedObjectContext *)managedObjectContext{
    //finds the applications appdelegate, casts it to the type of our "AppDelegate" and then it will find the managedobjectcontext
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

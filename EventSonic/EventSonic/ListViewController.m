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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    vc.name.text = @"hi";

}

//Table view delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;//this needs to be revisited, should be equal to the number of events in the coredata
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * cellID = @"cellID";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if(cell ==nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    cell.textLabel.text = [self.name objectAtIndex:indexPath.row];
//    return cell;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
    }
    //will call the coredata and get all the events, and then populate the name with the name of the event
    cell.textLabel.text = [NSString stringWithFormat: @"Index row of this cell: %ld", indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"selected a specific row");
//    UIStoryboard * storyboard = self.storyboard;
//    EventsController * vc = [storyboard instantiateViewControllerWithIdentifier:@"eventView"];
//    vc.callingView = self;
//    [self presentViewController:vc animated:YES completion:nil];
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

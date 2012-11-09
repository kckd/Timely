//
//  TMYActualTimerTableViewController.m
//  Timely
//
//  Created by Matthew Phillips on 9/29/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYActualTimerTableViewController.h"
#import "TMYActualTimerViewController.h"
#import "TMYActualTimer.h"
#import "TMYActualTimers.h"

@interface TMYActualTimerTableViewController ()

@end

@implementation TMYActualTimerTableViewController


@synthesize auiUpdateTimer;


NSMutableArray *actualTimers = nil;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgtest2.png"]];
    
    actualTimers = [TMYActualTimers actualTimers];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self.tableView reloadData];
    
    
    self.auiUpdateTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0f target:self selector:@selector(auiupdateTimer) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.auiUpdateTimer invalidate];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [actualTimers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ATimerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TMYActualTimer *actualTimer = [actualTimers objectAtIndex:[indexPath row]];
    
    

    [[cell textLabel] setText:actualTimer.name];
    //[[cell detailTextLabel] setText:actualTimer.intervalString];
    
    return cell;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [actualTimers removeObjectAtIndex:indexPath.row];
        // delete the row from the table
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


#pragma mark -
#pragma mark Table view selection

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
   if ([[segue identifier] isEqualToString:@"SelectedATimerCell"]) {
        
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        TMYActualTimerViewController *timerViewController = [segue destinationViewController];
        timerViewController.actualTimer = [actualTimers objectAtIndex:selectedRowIndex.row];
    } else if ([[segue identifier] isEqualToString:@"AddNewTimer"]) {
        TMYActualTimerViewController *timerViewController = [segue destinationViewController];
        TMYActualTimer *newTimer = [[TMYActualTimer alloc] init];
        timerViewController.actualTimer = newTimer;
        [actualTimers addObject:newTimer];
    }
}

-(void)auiupdateTimer
{
    if (self.tableView.dragging) { // Trying to update the timers while scrolling would cause performance issues.
        return;
    }
}

@end

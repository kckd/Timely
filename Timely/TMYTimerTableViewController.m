//
//  TMYTimerTableViewController.m
//  Timely
//
//  Created by Casey Cady on 7/17/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYTimerTableViewController.h"
#import "TMYTimerViewController.h"
#import "TMYTimers.h"
#import "TMYTimer.h"

@interface TMYTimerTableViewController ()
@property (nonatomic,retain) NSTimer *uiUpdateTimer;
-(void)updateTimer;
@end

@implementation TMYTimerTableViewController
@synthesize uiUpdateTimer;

#define UPDATE_INTERVAL 1.0/10 // 10ms

NSMutableArray *timers = nil;

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
    
    timers = [TMYTimers timers];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
//    // Cleanup empty timers
//    for (TMYTimer *timer in [NSArray arrayWithArray:timers])
//    {
//        if (timer.name.length == 0 && !timer.running) {
//            [timers removeObject:timer];
//        }
//    }
    
    [self.tableView reloadData];
    
    self.uiUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_INTERVAL target:self selector:@selector(updateTimer) userInfo:nil
        repeats:YES];
    
    if (timers.count > 0)
        self.editButtonItem.enabled = YES;
    else
        self.editButtonItem.enabled = NO;
        
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.uiUpdateTimer invalidate];
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
    return [timers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TMYTimer *timer = [timers objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:timer.name];
    [[cell detailTextLabel] setText:timer.intervalString];
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [timers removeObjectAtIndex:indexPath.row];
        // delete the row from the table
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (timers.count == 0) {
            [self setEditing:NO animated:YES];
            self.editButtonItem.enabled = NO;
        }
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
    if ([[segue identifier] isEqualToString:@"ShowSelectedTimer"]) {
        
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        TMYTimerViewController *timerViewController = [segue destinationViewController];
        timerViewController.timer = [timers objectAtIndex:selectedRowIndex.row];
    } else if ([[segue identifier] isEqualToString:@"ShowNewTimer"]) {
        TMYTimerViewController *timerViewController = [segue destinationViewController];
        TMYTimer *newTimer = [[TMYTimer alloc] init];
        timerViewController.timer = newTimer;
        [timers addObject:newTimer];
    }
}

-(void)updateTimer
{
    if (self.tableView.dragging) { // Trying to update the timers while scrolling would cause performance issues.
        return;
    }
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        TMYTimer *timer = [timers objectAtIndex:[[self.tableView indexPathForCell:cell] row]];
        [cell.detailTextLabel setText:timer.intervalString];
    }; 
}

@end

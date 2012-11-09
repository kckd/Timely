//
//  TMYTimerSettingsRootTableViewController.m
//  Timely
//
//  Created by Matthew Phillips on 10/26/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYTimerSettingsRootTableViewController.h"

#import "TMYTimerSelectedOptionTableViewController.h"

@interface TMYTimerSettingsRootTableViewController ()

@end

@implementation TMYTimerSettingsRootTableViewController

@synthesize timeroptionsArray;


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
    
    timeroptionsArray = [NSArray arrayWithObjects: @"Font Color", @"Background Color", nil];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
   
}

-(void)viewDidUnload
{
    self.timeroptionsArray=nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [timeroptionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimerSettingsOption";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
     // Configure the cell...    
    cell.textLabel.text = [timeroptionsArray objectAtIndex:indexPath.row];
   
    
    
    return cell;
}



#pragma mark - Table view delegate



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ShowSelectedTimerOption"]) {
        
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        TMYTimerSelectedOptionTableViewController *timerViewController = [segue destinationViewController];
        timerViewController.choice = [timeroptionsArray objectAtIndex:selectedRowIndex.row];
        
    }
    
}
@end

//
//  TMYTimerSelectedOptionTableViewController.m
//  Timely
//
//  Created by Matthew Phillips on 10/26/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYTimerSelectedOptionTableViewController.h"
#import "TMYTimerSettingsRootTableViewController.h"
#import "TMYAppDelegate.h"
#import "TMYActualTimerViewController.h"

@interface TMYTimerSelectedOptionTableViewController ()

@end

@implementation TMYTimerSelectedOptionTableViewController

@synthesize choice;
@synthesize timeroptionsArray;
@synthesize colorArray;
@synthesize backgroundArray;






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

    self.title = [NSString stringWithFormat:@"%@",choice];
    
       
    
    colorArray = [NSArray arrayWithObjects: @"Red", @"Green", @"Orange", @"Purple", nil];
    backgroundArray = [NSArray arrayWithObjects: @"Black", @"Blue", @"Orange", @"Purple", nil];
    
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
    if ([self.title isEqualToString:@"Font Color"]){
        
    
        return [colorArray count];
    } else
        return [backgroundArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
  
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
    }
    
    if ([self.title isEqualToString:@"Font Color"])
    
    {
    cell.textLabel.text = [colorArray objectAtIndex:indexPath.row];
        // Configure the cell...
        
        return cell;
    }
    else
        cell.textLabel.text = [backgroundArray objectAtIndex:indexPath.row];
    return cell;
    
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    TMYAppDelegate *appDelegateDos = (TMYAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    TMYAppDelegate *appDelegateBackground = (TMYAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    if ([self.title isEqualToString: @"Font Color"])
    {
    
    if (indexPath.row==0)
    {
        // this will carry over the color
        [appDelegateDos.timerData setString:@"Red"];
        
    }
    
    else if (indexPath.row ==1)
    {
        [appDelegateDos.timerData setString:@"Green"];
        
    }
    else if (indexPath.row == 2)
    {
        [appDelegateDos.timerData setString:@"Orange"];
        
    }
    else if (indexPath.row == 3)
    {
        [appDelegateDos.timerData setString:@"Purple"];
        
    }
    
    }
    
        if ([self.title isEqualToString: @"Background Color"])
        {
            if (indexPath.row==0)
            {
                // this will carry over the color
                [appDelegateBackground.timerData2 setString:@"Black"];
                
            }
            
            else if (indexPath.row ==1)
            {
                [appDelegateBackground.timerData2 setString:@"Blue"];
                
            }
            else if (indexPath.row == 2)
            {
                [appDelegateBackground.timerData2 setString:@"Orange"];
                
            }
            else if (indexPath.row == 3)
            {
                [appDelegateBackground.timerData2 setString:@"Purple"];
                
            }
            
            
        }
        
     [self.navigationController popViewControllerAnimated:YES];
    
}

@end

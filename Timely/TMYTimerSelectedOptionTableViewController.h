//
//  TMYTimerSelectedOptionTableViewController.h
//  Timely
//
//  Created by Matthew Phillips on 10/26/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMYTimerSettingsRootTableViewController.h"
#import "TMYAppDelegate.h"
#import "TMYActualTimerViewController.h"


@interface TMYTimerSelectedOptionTableViewController : UITableViewController

@property (weak, nonatomic) TMYTimerSettingsRootTableViewController *timeroptionsArray;



@property (nonatomic, retain) NSArray *colorArray;

@property (nonatomic, retain) NSArray *backgroundArray;

@property NSString *choice;


@end

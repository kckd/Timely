//
//  TMYViewController.h
//  Timely
//
//  Created by Casey Cady on 7/15/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMYViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *OneMinuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *TenMinuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *TenSecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *OneSecondLabel;

@end

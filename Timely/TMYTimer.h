//
//  TMYTimer.h
//  Timely
//
//  Created by Casey Cady on 7/17/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMYTimer : NSObject
@property (retain) NSString *Name;
@property (retain) NSDate *CurrentStartDate;
@property (nonatomic) NSTimeInterval Interval;
@property BOOL Running;

-(void)startTimer;
-(void)stopTimer;
-(void)resetTimer;

@end

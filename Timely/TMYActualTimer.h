//
//  TMYActualTimer.h
//  Timely
//
//  Created by Matthew Phillips on 10/24/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMYActualTimer : NSObject
@property (retain) NSString *name;
@property (nonatomic) NSTimeInterval endInterval;
@property (retain) NSDate *endDate;
@property BOOL running;


-(void)startActualTimer;
-(void)stopActualTimer;
-(void)resetActualTimer;
@end

//
//  TMYTimerMutableArray.h
//  Timely
//
//  Created by Casey Cady on 7/17/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMYTimerMutableArray : NSMutableArray

+(TMYTimerMutableArray*)timers;

+(void)saveTimers;

@end

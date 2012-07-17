//
//  TMYTimerMutableArray.m
//  Timely
//
//  Created by Casey Cady on 7/17/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYTimerMutableArray.h"

@implementation TMYTimerMutableArray

static NSMutableArray* sharedTimers = nil;



+(NSMutableArray*)timers
{
    if (!sharedTimers) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //make a file name to write the data to using the documents directory:
        NSString *fileName = [NSString stringWithFormat:@"%@/Timers.plist",
                              documentsDirectory];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        {
            sharedTimers = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
        } else
        {
            sharedTimers = [[NSMutableArray alloc] init];
        }
    }
    return sharedTimers;
}

+(void)saveTimers
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/Timers.plist",
                          documentsDirectory];
    [NSKeyedArchiver archiveRootObject:[TMYTimerMutableArray timers]
                                toFile:fileName];
}

@end

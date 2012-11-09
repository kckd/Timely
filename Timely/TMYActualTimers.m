//
//  TMYActualTimers.m
//  Timely
//
//  Created by Matthew Phillips on 10/24/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYActualTimers.h"

@implementation TMYActualTimers



static NSMutableArray* sharedActualTimers = nil;

+(NSMutableArray*)actualTimers
{
    if (!sharedActualTimers) {
        NSArray *apaths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *adocumentsDirectory = [apaths objectAtIndex:0];
        
        //make a file name to write the data to using the documents directory:
        NSString *afileName = [NSString stringWithFormat:@"%@/ActuaTimers.plist",
                              adocumentsDirectory];
        if ([[NSFileManager defaultManager] fileExistsAtPath:afileName])
        {
            sharedActualTimers = [NSKeyedUnarchiver unarchiveObjectWithFile:afileName];
        } else
        {
            sharedActualTimers = [[NSMutableArray alloc] init];
        }
    }
    return sharedActualTimers;
}



+(void)saveActualTimers
{
    NSArray *apaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *adocumentsDirectory = [apaths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *afileName = [NSString stringWithFormat:@"%@/ActualTimers.plist",
                          adocumentsDirectory];
    [NSKeyedArchiver archiveRootObject:[TMYActualTimers actualTimers]
                                toFile:afileName];
}

@end
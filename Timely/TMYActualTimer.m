//
//  TMYActualTimer.m
//  Timely
//
//  Created by Matthew Phillips on 10/24/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYActualTimer.h"

@implementation TMYActualTimer
@synthesize name;



-(TMYActualTimer*)init
{
    self = [super init];
    
    if (self) // Objective-C rule: [super init] can return nil, so always check before doing any work in your
        // init method.
    {
        //Init methods should never use the accessor methods, as the object is in a partially initialized state.
        // So you would never call self.Interval within init. The same rule applies to dealloc.
        _endInterval = 0;
        _running = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    
    if (self)
    {
        name = [coder decodeObjectForKey:@"TMYActualName"];
        _endInterval = [coder decodeIntForKey:@"TMYEndInterval"];
        _running = [coder decodeBoolForKey:@"TMYActualRunning"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"TMYActualName"];
    [coder encodeInt:self.endInterval forKey:@"TMYEndInterval"];
    [coder encodeBool:self.running forKey:@"TMYActualRunning"];
}


-(void)startActualTimer
{
    if (!self.running)
    {
        self.running = YES;
        self.endDate = [NSDate dateWithTimeInterval:self.endInterval sinceDate:[NSDate date]];
    }
    
}

-(void)stopActualTimer
{
    self.running = NO;
    self.endInterval = [self.endDate timeIntervalSinceDate:[NSDate date]];
    self.endDate = nil;
    
}

-(void)resetActualTimer
{
    [self stopActualTimer];
    self.endInterval = 0;
}


@end

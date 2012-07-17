//
//  TMYTimer.m
//  Timely
//
//  Created by Casey Cady on 7/17/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import "TMYTimer.h"

@implementation TMYTimer
@synthesize Name;
@synthesize Interval;
@synthesize CurrentStartDate;
@synthesize Running;

-(TMYTimer*)init
{
    self = [super init];
    
    if (self) // Objective-C rule: [super init] can return nil, so always check before doing any work in your
              // init method. 
    {
        //Init methods should never use the accessor methods, as the object is in a partially initialized state.
        // So you would never call self.Interval within init. The same rule applies to dealloc.
        Interval = 0;
        Running = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    
    if (self) 
    {
        Name = [coder decodeObjectForKey:@"TMYName"];
        Interval = [coder decodeIntForKey:@"TMYInterval"];
        CurrentStartDate = [coder decodeObjectForKey:@"TMYCurrentStartDate"];
        Running = [coder decodeBoolForKey:@"TMYRunning"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.Name forKey:@"TMYName"];
    [coder encodeInt:self.Interval forKey:@"TMYInterval"];
    [coder encodeObject:self.CurrentStartDate forKey:@"TMYCurrentStartDate"];
    [coder encodeBool:self.Running forKey:@"TMYRunning"];
}

// This overrides the synthesized getter. The setter remains synthesized (and is called -(void)setInterval:(NSTimeInterval))
// As clever as this seems, it probably isn't a good idea to have a getter
// return something different from the ivar. See below for an example
// of why it is confusing.
// The correct design would be to have a readonly Interval property, which would imply that the value it returns
// is not directly settable.
-(NSTimeInterval)Interval
{
    if (self.CurrentStartDate) {
        // this illustrates an important difference between self.Interval and Interval.
        // self.Interval calls the property's getter method. Interval is the instance variable (ivar).
        // If I had used self.Interval, I would have gotten an infinite loop.
        return Interval + [[NSDate date] timeIntervalSinceDate:CurrentStartDate];
    } else
        return Interval;
}

-(void)startTimer
{
    if (!self.Running)
    {
        self.CurrentStartDate = [NSDate date];
        self.Running = YES;
    }
    
}

-(void)stopTimer
{
    self.Interval = self.Interval;  // Whoa. Don't do this. I did it this way to illustrate the difference between the
                                    // synthesized setter and the overridden getter.
                                    // It takes advantage of a side effect of the getter (it adds the value of the ivar to the
                                    // current interval since the start date). It also illustrates why having a getter that
                                    // returns a different value than you pass in to the setter gets confusing really fast.
    self.CurrentStartDate = nil;
    self.Running = NO;
    
}

-(void)resetTimer
{
    [self stopTimer];
    self.Interval = 0;
}

@end

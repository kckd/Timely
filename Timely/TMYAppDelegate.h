//
//  TMYAppDelegate.h
//  Timely
//
//  Created by Casey Cady on 7/15/12.
//  Copyright (c) 2012 Deloitte Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMYAppDelegate : UIResponder <UIApplicationDelegate>{
    NSMutableString *data;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableString *data;
@property (strong, nonatomic) NSMutableString *data2;

@property (strong, nonatomic) NSMutableString *timerData;

@property (strong, nonatomic) NSMutableString *timerData2;


@end

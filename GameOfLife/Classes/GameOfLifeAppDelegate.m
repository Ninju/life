//
//  GameOfLifeAppDelegate.m
//  GameOfLife
//
//  Created by Nicholas Wright on 2/8/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "GameOfLifeAppDelegate.h"
#import "RootViewController.h"

@implementation GameOfLifeAppDelegate


@synthesize window;
@synthesize rootViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    [window addSubview:[rootViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [rootViewController release];
    [window release];
    [super dealloc];
}

@end

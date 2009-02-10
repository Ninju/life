//
//  MainView.m
//  GameOfLife
//
//  Created by Nicholas Wright on 2/8/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "MainView.h"
#import "Game.h"

@implementation MainView

@synthesize game;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib  {
	[super awakeFromNib];
	
	game = [[Game alloc] initGrid];	
	[game setupBoard];
	[self startTimer];
}

- (void)playGame {
	[self setNeedsDisplay];
}

- (void)startTimer {
	[self stopTimer];
	timer = [NSTimer scheduledTimerWithTimeInterval: .2
											 target: self
										   selector: @selector(playGame)
										   userInfo: nil
											repeats: YES];
}

- (void)stopTimer {
	if ( timer ) {
		[timer invalidate];
		timer = NULL;
	}
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[game setupBoard];
	[self startTimer];
	[self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	if ( ![game drawBoard] ) {
		[self stopTimer];
	}
}


- (void)dealloc {
	[self stopTimer];
	[game release];
    [super dealloc];
}


@end

//
//  MainView.h
//  GameOfLife
//
//  Created by Nicholas Wright on 2/8/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;

@interface MainView : UIView {
	Game *game;
	NSTimer *timer;
}

@property (nonatomic, retain) Game *game;

- (void)playGame;
- (void)startTimer;
- (void)stopTimer;

@end

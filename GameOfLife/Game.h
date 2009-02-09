//
//  Game.h
//  GameOfLife
//
//  Created by Nicholas Wright on 2/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define COLS 32
#define ROWS 48
#define SIZE 10

@interface Game : NSObject {
	int cell_rows;
	int cell_cols;
	int cell_height;
	int cell_width;
	int current_generation;

	bool cells[ COLS ][ ROWS ];
	bool next_generation[ COLS ][ ROWS ];
}

- (id)initGrid;
- (void)reset;
- (void)setupBoard;
- (bool)withinBoundsX:(int)x y:(int)y;
- (bool)drawBoard;
- (bool)cellAliveAtX:(int)x y:(int)y;
- (bool)runSimulation;
- (void)drawCellForX:(int)x y:(int)y;

@end

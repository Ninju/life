//
//  Game.m
//  GameOfLife
//
//  Created by Nicholas Wright on 1/17/09.
//  Copyright 2009 appsbynick.com. All rights reserved.
//

#import "Game.h"
#include <stdlib.h>

@implementation Game

- (id)initGrid {
	if ( self = [super init] ) {
		cell_rows   = ROWS;
		cell_cols   = COLS;
		cell_height = SIZE;
		cell_width  = SIZE;
	}
	
	return self;
}

- (void)setupBoard {
	int x, y;
	
	for ( x = 0; x < cell_cols; x++ ) {
		for ( y = 0; y < cell_rows; y++ ) {
			cells[ x ][ y ] = arc4random() % 15	== 0;
		}
	}
}

- (bool)withinBoundsX:(int)x y:(int)y {
	if ( ( x >= 0 ) && ( x < cell_cols ) &&
		( y >= 0 ) && ( y < cell_rows ) ) {
		return YES;
	}
	return NO;
}

- (bool)drawBoard {
	int x, y;
	for ( x = 0; x < cell_cols; x++ ) {
		for ( y = 0; y < cell_rows; y++ ) {
			if ( [self cellAliveAtX:x y:y] ) {
				[self drawCellForX:x y:y];
			}
		}
	}
	
	return [self runSimulation];
}

- (bool)cellAliveAtX:(int)x y:(int)y {
	bool alive = cells[ x ][ y ];
	if ( ( [self withinBoundsX:x y:y] ) && ( alive ) ) {
		alive = YES;
	} else {
		alive = cells[ cell_cols - x ][ cell_rows - y ];
	}
	return alive;
}

- (bool)runSimulation {
	int x, y;
	bool dirty = NO;
    for ( x = 0; x < cell_cols; x++ ) {
		for ( y = 0; y < cell_rows; y++ ) {
			int aliveNeighbors = 0;
			
			if ( [self cellAliveAtX:x + 1 y:y] )     aliveNeighbors++;
			if ( [self cellAliveAtX:x - 1 y:y] )     aliveNeighbors++;
			if ( [self cellAliveAtX:x y:y + 1] )     aliveNeighbors++;
			if ( [self cellAliveAtX:x y:y - 1] )     aliveNeighbors++;
			if ( [self cellAliveAtX:x + 1 y:y - 1] ) aliveNeighbors++;
			if ( [self cellAliveAtX:x + 1 y:y + 1] ) aliveNeighbors++;
			if ( [self cellAliveAtX:x - 1 y:y - 1] ) aliveNeighbors++;
			if ( [self cellAliveAtX:x - 1 y:y + 1] ) aliveNeighbors++;	
			
			bool wasAlive = cells[ y ][ x ];

			bool nowAlive = ( ( ( !wasAlive ) && ( aliveNeighbors == 3 ) ) ||
							  ( ( wasAlive ) && ( ( aliveNeighbors == 2 )  || ( aliveNeighbors == 3 ) ) ) );
			
			if ( ( !dirty ) && ( nowAlive != wasAlive ) ) {
				dirty = YES;
			}
			next_generation[ x ][ y ] = nowAlive;
		}
	}
	
    for ( x = 0; x < cell_cols; x++ ) {
		for ( y = 0; y < cell_rows; y++ ) {
			cells[ x ][ y ] = next_generation[ x ][ y ];
		}
	}
	
	return dirty;
}

- (void)drawCellForX:(int)x y:(int)y {
	CGRect rect = CGRectMake( x * cell_width, y * cell_height, cell_width - 1, cell_height - 1 );
	
	[[UIColor yellowColor] setFill];
	UIRectFill( rect );
	
/*
	NSString *path = [[NSString alloc] initWithFormat:@"bug.png"];
	UIImage *bug = [UIImage imageNamed:path];
	[bug drawInRect:rect];
	[path release];
*/
}

- (void)dealloc {
	[super dealloc];
}

@end
//
//  ComputerMove.m
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/28/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import "ComputerMove.h"
#import "GlobalDefines.h"
#import "Game.h"
#import "Move.h"

@implementation ComputerMove

+(CGPoint)moveWithState:(NSArray*)moves game:(Game*)game andInverseMistake:(int)mistake {
	NSMutableArray* shuffledMoves = [NSMutableArray arrayWithArray:moves];
	[shuffledMoves shuffle];
		
	// Try to win
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [ComputerMove moveToWin:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	// Try to stop someone else winning
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [ComputerMove moveToStopSomeoneFromWinning:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	// Try to stop a !000!
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [ComputerMove moveToStop4InARowWithState:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	// Try to get a !000!
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [ComputerMove moveToGet4InARowWithState:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	// MORE RULES HERE
	
	// Can I make a !XX! turn into a !XXX!
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [ComputerMove moveToGet3InARowWithState:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	// try to do a move close to the rest of the stuff
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [ComputerMove moveCloseToOtherMovesWithState:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	return [self moveRandomWithState:moves andGame:game];
}

+(CGPoint)moveToWin:(NSArray*)moves andGame:(Game*)game{
	Player* me = [game turn];
	CGPoint cell;
	
	for (Move* m in moves) {
		if ([m owner] == me) {
			// Check to the right
			if ([[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 3, m.cell.y)] owner] == me
				) {
				cell = CGPointMake(m.cell.x + 4, m.cell.y);
				if ([game cellIsValid:cell]) return cell;
				cell = CGPointMake(m.cell.x - 1, m.cell.y);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom 
			if ([[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 1)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 2)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 3)] owner] == me
				) {
				cell = CGPointMake(m.cell.x, m.cell.y + 4);
				if ([game cellIsValid:cell]) return cell;
				cell = CGPointMake(m.cell.x, m.cell.y - 1);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom right
			if ([[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y + 1)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y + 2)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 3, m.cell.y + 3)] owner] == me 
				) {
				cell = CGPointMake(m.cell.x + 4, m.cell.y + 4);
				if ([game cellIsValid:cell]) return cell;
				cell = CGPointMake(m.cell.x - 1, m.cell.y - 1);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom left
			if ([[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y + 1)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 2, m.cell.y + 2)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 3, m.cell.y + 3)] owner] == me 
				) {
				cell = CGPointMake(m.cell.x - 4, m.cell.y + 4);
				if ([game cellIsValid:cell]) return cell;
				cell = CGPointMake(m.cell.x + 1, m.cell.y - 1);
				if ([game cellIsValid:cell]) return cell;
			}
		}
	}
	return CGPointMake(-1, -1);
}

+(CGPoint)moveToStopSomeoneFromWinning:(NSArray*)moves andGame:(Game*)game{
	Player* me = [game turn];
	Player* enemy;
	
	CGPoint cell;
	
	for (Move* m in moves) {
		if ([m owner] != me) {
			enemy = [m owner];
			// Check to the right
			if ([[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 3, m.cell.y)] owner] == enemy
				) {
				cell = CGPointMake(m.cell.x + 4, m.cell.y);
				if ([game cellIsValid:cell]) return cell;
				cell = CGPointMake(m.cell.x - 1, m.cell.y);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom 
			if ([[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 1)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 2)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 3)] owner] == enemy
				) {
				cell = CGPointMake(m.cell.x, m.cell.y + 4);
				if ([game cellIsValid:cell]) return cell;
				cell = CGPointMake(m.cell.x, m.cell.y - 1);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom right
			if ([[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y + 1)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y + 2)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 3, m.cell.y + 3)] owner] == enemy 
				) {
				cell = CGPointMake(m.cell.x + 4, m.cell.y + 4);
				if ([game cellIsValid:cell]) return cell;
				cell = CGPointMake(m.cell.x - 1, m.cell.y - 1);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom left
			if ([[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y + 1)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 2, m.cell.y + 2)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 3, m.cell.y + 3)] owner] == enemy 
				) {
				cell = CGPointMake(m.cell.x - 4, m.cell.y + 4);
				if ([game cellIsValid:cell]) return cell;
				cell = CGPointMake(m.cell.x + 1, m.cell.y - 1);
				if ([game cellIsValid:cell]) return cell;
			}
			
		}
	}
	return CGPointMake(-1, -1);
}


+(CGPoint)moveToStop4InARowWithState:(NSArray*)moves andGame:(Game*)game{
	Player* me = [game turn];
	Player* enemy;
	
	CGPoint cell;
	
	for (Move* m in moves) {
		if ([m owner] != me) {
			enemy = [m owner];
			// Check to the right
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y)] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y)] owner] == enemy  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 3, m.cell.y)] == nil
				) {
				cell = CGPointMake(m.cell.x + 3, m.cell.y);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y    )] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 1)] owner] == enemy  &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 2)] owner] == enemy  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 3)] == nil
				) {
				cell = CGPointMake(m.cell.x, m.cell.y + 3);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the botom right
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y    )] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y + 1)] owner] == enemy  &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y + 2)] owner] == enemy  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 3, m.cell.y + 3)] == nil
				) {
				cell = CGPointMake(m.cell.x + 3, m.cell.y + 3);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the botom left
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y    )] owner] == enemy &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y + 1)] owner] == enemy  &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 2, m.cell.y + 2)] owner] == enemy  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 3, m.cell.y + 3)] == nil
				) {
				cell = CGPointMake(m.cell.x - 3, m.cell.y + 3);
				if ([game cellIsValid:cell]) return cell;
			}
			
		}
	}
	return CGPointMake(-1, -1);
}

+(CGPoint)moveToGet4InARowWithState:(NSArray*)moves andGame:(Game*)game{
	Player* me = [game turn];
	CGPoint cell;
	
	for (Move* m in moves) {
		if ([m owner] == me) {
			// Check to the right
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y)] owner] == me  &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y)] owner] == me  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 3, m.cell.y)] == nil
				) {
				cell = CGPointMake(m.cell.x + 3, m.cell.y);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y    )] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 1)] owner] == me  &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 2)] owner] == me  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 3)] == nil
				) {
				cell = CGPointMake(m.cell.x, m.cell.y + 3);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the botom right
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y    )] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y + 1)] owner] == me  &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y + 2)] owner] == me  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 3, m.cell.y + 3)] == nil
				) {
				cell = CGPointMake(m.cell.x + 3, m.cell.y + 3);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the botom left
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y    )] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y + 1)] owner] == me  &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 2, m.cell.y + 2)] owner] == me  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 3, m.cell.y + 3)] == nil
				) {
				cell = CGPointMake(m.cell.x - 3, m.cell.y + 3);
				if ([game cellIsValid:cell]) return cell;
			}
			
		}
	}
	return CGPointMake(-1, -1);
}

+(CGPoint)moveToGet3InARowWithState:(NSArray*)moves andGame:(Game*)game{
	Player* me = [game turn];
	CGPoint cell;
	
	for (Move* m in moves) {
		if ([m owner] == me) {
			// Check to the right
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y)] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y)] owner] == me  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y)] == nil
				) {
				cell = CGPointMake(m.cell.x + 2, m.cell.y);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the bottom
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y    )] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 1)] owner] == me  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x, m.cell.y + 2)] == nil
				) {
				cell = CGPointMake(m.cell.x, m.cell.y + 2);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the botom right
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y    )] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y + 1)] owner] == me  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 2, m.cell.y + 2)] == nil
				) {
				cell = CGPointMake(m.cell.x + 2, m.cell.y + 2);
				if ([game cellIsValid:cell]) return cell;
			}
			
			// Check to the botom left
			if ([ game getMoveFromArrayWithCell:CGPointMake(m.cell.x + 1, m.cell.y - 1)] == nil &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x    , m.cell.y    )] owner] == me &&
				[[game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 1, m.cell.y + 1)] owner] == me  &&
				[ game getMoveFromArrayWithCell:CGPointMake(m.cell.x - 2, m.cell.y + 2)] == nil
				) {
				cell = CGPointMake(m.cell.x - 2, m.cell.y + 2);
				if ([game cellIsValid:cell]) return cell;
			}
			
		}
	}
	return CGPointMake(-1, -1);
}

+(CGPoint)moveCloseToOtherMovesWithState:(NSArray*)moves andGame:(Game*)game{
	for (Move* m in moves) {
		CGPoint cell;
		
		cell = CGPointMake(m.cell.x, m.cell.y+1);
		if ([game cellIsValid:cell] && [game getMoveFromArrayWithCell:cell] == nil) {
			return cell;
		}
		cell = CGPointMake(m.cell.x, m.cell.y-1);
		if ([game cellIsValid:cell] && [game getMoveFromArrayWithCell:cell] == nil) {
			return cell;
		}
		cell = CGPointMake(m.cell.x + 1, m.cell.y);
		if ([game cellIsValid:cell] && [game getMoveFromArrayWithCell:cell] == nil) {
			return cell;
		}
		cell = CGPointMake(m.cell.x - 1, m.cell.y);
		if ([game cellIsValid:cell] && [game getMoveFromArrayWithCell:cell] == nil) {
			return cell;
		}
	}
	return CGPointMake(-1, -1);
}

+(CGPoint)moveRandomWithState:(NSArray*)moves andGame:(Game*)game{
	CGPoint point = CGPointMake(floor(BOARD_SIZE/2), floor(BOARD_SIZE/2));
	while ([game getMoveFromArrayWithCell:point] != nil) {
		point = CGPointMake(arc4random() % BOARD_SIZE,arc4random() %  BOARD_SIZE);
	}
	return point;	
}

@end

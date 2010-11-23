//
//  Player.m
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import "Player.h"
#import "GlobalDefines.h"
#import "Move.h"
#import "Game.h"

@implementation Player

@synthesize local, name, image, computer;

-(CGPoint)moveWithState:(NSArray*)moves andGame:(Game*)game{
	NSMutableArray* shuffledMoves = [NSMutableArray arrayWithArray:moves];
	[shuffledMoves shuffle];
	
	int mistake = 90; // inverse mistake

	// Try to win
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [self moveToWin:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
		
	// Try to stop someone else winning
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [self moveToStopSomeoneFromWinning:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	// Try to stop a !000!
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [self moveToStop4InARowWithState:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	// Try to get a !000!
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [self moveToGet4InARowWithState:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
	
	// MORE RULES HERE

	// Can I make a !XX! turn into a !XXX!
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [self moveToGet3InARowWithState:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}
		
	// try to do a move close to the rest of the stuff
	if (arc4random() % 100 < mistake) {
		CGPoint cell = [self moveCloseToOtherMovesWithState:shuffledMoves andGame:game];
		if ([game cellIsValid:cell]) return cell;
	}

	return [self moveRandomWithState:moves andGame:game];
	
}

-(CGPoint)moveToWin:(NSArray*)moves andGame:(Game*)game{
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

-(CGPoint)moveToStopSomeoneFromWinning:(NSArray*)moves andGame:(Game*)game{
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


-(CGPoint)moveToStop4InARowWithState:(NSArray*)moves andGame:(Game*)game{
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

-(CGPoint)moveToGet4InARowWithState:(NSArray*)moves andGame:(Game*)game{
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

-(CGPoint)moveToGet3InARowWithState:(NSArray*)moves andGame:(Game*)game{
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

-(CGPoint)moveCloseToOtherMovesWithState:(NSArray*)moves andGame:(Game*)game{
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

-(CGPoint)moveRandomWithState:(NSArray*)moves andGame:(Game*)game{
	CGPoint point = CGPointMake(floor(BOARD_SIZE/2), floor(BOARD_SIZE/2));
	while ([game getMoveFromArrayWithCell:point] != nil) {
		point = CGPointMake(arc4random() % BOARD_SIZE,arc4random() %  BOARD_SIZE);
	}
	return point;	
}


+(NSString*)getHardCodedImageForIndex:(int)i{
	if (i == 0) return @"red_circle.png";
	if (i == 1) return @"orange_cross.png";
	if (i == 2) return @"blue_cross.png";
	if (i == 3) return @"purple_circle.png";
	if (i == 4) return @"purple_cross.png";
	if (i == 5) return @"blue_circle.png";
	if (i == 6) return @"red_cross.png";
	if (i == 7) return @"green_circle.png";
	if (i == 8) return @"orange_circle.png";
	if (i == 9) return @"green_cross.png";
	return @"red_circle.png";
}

@end

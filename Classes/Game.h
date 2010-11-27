//
//  Game.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Move, Game, Player;

@protocol GameProtocol <NSObject>
@required
- (void) game:(Game*)game playerJustWon:(Player*)player;
- (void) game:(Game*)game newStateActive:(BOOL)active;
- (void) game:(Game*)game newMove:(Move*)move;
@end

@interface Game : NSObject {
	id <GameProtocol> delegate;

	NSMutableArray *players;
	NSMutableArray *moves;
	Player *turn;
	
	UIView *lastMove;
}

@property (retain, nonatomic) id delegate;
@property (nonatomic, retain) NSMutableArray *players;
@property (nonatomic, retain) NSMutableArray *moves;
@property (nonatomic, retain) Player* turn;

- (void)  startLocally;
- (void)  startNetworkedGame;

- (BOOL)  checkForWin;
- (void)  computerMove;
- (void)  getNextActivePlayer;
- (void)  tryToAddMoveInCell:(CGPoint)cell;
- (void)  addMove:(CGPoint)cell;
- (BOOL)  cellIsValid:(CGPoint)cell;
- (Move*) getMoveFromArrayWithCell:(CGPoint)cell;

@end

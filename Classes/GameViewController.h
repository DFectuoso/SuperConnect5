//
//  GameViewController.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GameBoard.h"
#import "Game.h"

@class GameBoard, Game, Move, Player;

@interface GameViewController : UIViewController<GameProtocol, GameBoardTouchesProtocol, GKMatchmakerViewControllerDelegate, GKMatchDelegate> {
	IBOutlet UIImageView *header;
	IBOutlet UIImageView *headerActive;
	IBOutlet UILabel *headerLabel;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *turnImageView;
	
//	IBOutlet UITextView *debugTextView;
	
	UIView *overlay;
	GameBoard *gameBoard;
	Game *game;
	
	BOOL matchStarted;
	
	int localPlayers;
	int computerPlayers;
	int networkPlayers;	
}

@property int localPlayers;
@property int computerPlayers;
@property int networkPlayers;

// Two ways to start:
// Set players from Data
// Set players with X Local X computers1

- (void) centerToMove:(Move*)move;
- (void) networkInit;
- (void) networkInitAddedAnotherPlayerToTheArray;
- (void) sendPlayerArray;
- (void) startNetworkGame;
- (void) sendMoveToNetwork:(Move*)m;

// Implement GameBoard Protocol Functions:
- (void) clickedOnCell: (CGPoint)cell;

// Implement Game Protocol Functions:
- (void) game:(Game*)game playerJustWon:(Player*)player;
- (void) game:(Game*)game newStateActive:(BOOL)active;
- (void) game:(Game*)game newMove:(Move*)move;


@end

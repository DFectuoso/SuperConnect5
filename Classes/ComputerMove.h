//
//  ComputerMove.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/28/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;

@interface ComputerMove : NSObject {

}

+(CGPoint)moveWithState:(NSArray*)moves game:(Game*)game andInverseMistake:(int)mistake;

// Computer moves
+(CGPoint)moveToWin:(NSArray*)moves andGame:(Game*)game;
+(CGPoint)moveToStopSomeoneFromWinning:(NSArray*)moves andGame:(Game*)game;
+(CGPoint)moveToStop4InARowWithState:(NSArray*)moves andGame:(Game*)game;
+(CGPoint)moveToGet4InARowWithState:(NSArray*)moves andGame:(Game*)game;
+(CGPoint)moveToGet3InARowWithState:(NSArray*)moves andGame:(Game*)game;
+(CGPoint)moveCloseToOtherMovesWithState:(NSArray*)moves andGame:(Game*)game;
+(CGPoint)moveRandomWithState:(NSArray*)moves andGame:(Game*)game;

@end

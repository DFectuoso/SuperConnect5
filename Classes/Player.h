//
//  Player.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Move,Player,Game;

@interface Player : NSObject {
	BOOL local;
	BOOL computer;
	NSString *name;
	UIImage *image;
}

@property BOOL local;
@property BOOL computer;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *image;

+(NSString*)getHardCodedImageForIndex:(int)i;
-(CGPoint)moveWithState:(NSArray*)moves andGame:(Game*)game;

// Computer moves
-(CGPoint)moveToWin:(NSArray*)moves andGame:(Game*)game;
-(CGPoint)moveToStopSomeoneFromWinning:(NSArray*)moves andGame:(Game*)game;
-(CGPoint)moveToStop4InARowWithState:(NSArray*)moves andGame:(Game*)game;
-(CGPoint)moveToGet4InARowWithState:(NSArray*)moves andGame:(Game*)game;
-(CGPoint)moveToGet3InARowWithState:(NSArray*)moves andGame:(Game*)game;
-(CGPoint)moveCloseToOtherMovesWithState:(NSArray*)moves andGame:(Game*)game;
-(CGPoint)moveRandomWithState:(NSArray*)moves andGame:(Game*)game;

@end

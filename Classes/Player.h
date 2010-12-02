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
	NSString *imageName;
	UIImage *image;
}

@property BOOL local;
@property BOOL computer;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) UIImage *image;

+(NSString*)getImageForIndex:(int)i;
-(CGPoint)moveWithState:(NSArray*)moves andGame:(Game*)game;

@end

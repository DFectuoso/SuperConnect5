//
//  Player.m
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import "Player.h"
#import "GlobalDefines.h"
#import "ComputerMove.h"
#import "Move.h"
#import "Game.h"

static NSMutableArray *iconsForPlayers = nil;
static BOOL randomized = NO;

@implementation Player

@synthesize local, name, image, computer, imageName;

-(CGPoint)moveWithState:(NSArray*)moves andGame:(Game*)game{
	return [ComputerMove moveWithState:moves game:game andInverseMistake:100];
}

+(void)randomizeImagesOrder{
	NSLog(@"Randomizing Images");
	if (iconsForPlayers){
		[iconsForPlayers release];
	}
	
	iconsForPlayers = [[NSMutableArray alloc] init];
	for (int i = 1; i < 24; i++) {
		[iconsForPlayers addObject:[NSNumber numberWithInt:i]];
	}
	[iconsForPlayers shuffle];
}

+(NSString*)getImageForIndex:(int)i{
	if (!randomized) {
		[Player randomizeImagesOrder];
		randomized = YES;
	}
	NSLog(@"Someone asked for %i and I searched on %@", i, iconsForPlayers);
	return [NSString stringWithFormat:@"icono%i.png",[[iconsForPlayers objectAtIndex:i] intValue]];
}

@end

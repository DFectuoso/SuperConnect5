//
//  Player.m
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize local, name, image;

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

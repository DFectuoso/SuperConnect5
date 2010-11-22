//
//  Player.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Player : NSObject {
	BOOL local;
	NSString *name;
	UIImage *image;
}

@property BOOL local;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *image;

+(NSString*)getHardCodedImageForIndex:(int)i;

@end

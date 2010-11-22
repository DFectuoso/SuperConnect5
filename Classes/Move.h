//
//  Move.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@interface Move : NSObject {
	CGPoint cell;
	Player *owner;
}

@property CGPoint cell;
@property (nonatomic, retain) Player* owner;

@end

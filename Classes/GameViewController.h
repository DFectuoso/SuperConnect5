//
//  GameViewController.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameViewController : UIViewController {
	int localPlayers;
	int computerPlayers;
	int networkPlayers;
	
}

@property int localPlayers;
@property int computerPlayers;
@property int networkPlayers;

@end

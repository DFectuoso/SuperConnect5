//
//  GameBoard.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Move;

@protocol GameBoardTouchesProtocol <NSObject>
@required
- (void) clickedOnCell: (CGPoint)cell;
@end

@interface GameBoard : UIView {
	id <GameBoardTouchesProtocol> delegate;
	
	UIView *lastMove;
}

@property (retain, nonatomic) id delegate;

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) addMove:(Move*)m;

@end

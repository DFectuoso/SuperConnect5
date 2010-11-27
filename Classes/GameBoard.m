//
//  GameBoard.m
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import "GameBoard.h"
#import "GlobalDefines.h"
#import "Move.h"

@implementation GameBoard

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		lastMove = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
		[lastMove setAlpha:0.3];
		[lastMove setHidden:YES];
		[lastMove setBackgroundColor:[UIColor greenColor]];
		[self addSubview:lastMove];
    }
    return self;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGPoint real = CGPointMake(floor(pt.x/CELL_SIZE), floor(pt.y/CELL_SIZE));
	
	[delegate clickedOnCell:real];
}

-(void) addMove:(Move*)m{
	
	UIImageView* iv = [[UIImageView alloc] initWithImage:[[m owner] image]];
	CGRect f = [iv frame];
	f.origin.x = (m.cell.x * CELL_SIZE);
	f.origin.y = (m.cell.y * CELL_SIZE);

	[lastMove setHidden:NO];
	[lastMove setFrame:f];
	[iv setFrame:f];
	[self addSubview:iv];
	[iv release];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	
    CGFloat blue[4] = {0.254f, 0.67f, 0.98f, 1.0f};
    CGContextSetStrokeColor(c, blue);
	CGContextSetLineWidth(c,2.0f);
	for (int i = 0; i < BOARD_SIZE; i++) {
		CGContextBeginPath(c);
		CGContextMoveToPoint(c, 0.0f, i * CELL_SIZE);
		CGContextAddLineToPoint(c, (BOARD_SIZE * CELL_SIZE), i * CELL_SIZE);
		CGContextStrokePath(c);
	}
	
	for (int i = 0; i < BOARD_SIZE; i++) {
		CGContextBeginPath(c);
		CGContextMoveToPoint(c, i * CELL_SIZE, 0);
		CGContextAddLineToPoint(c, i * CELL_SIZE, BOARD_SIZE * CELL_SIZE);
		CGContextStrokePath(c);
	}	
}

- (void)dealloc {
	[lastMove release];
    [super dealloc];
}

@end
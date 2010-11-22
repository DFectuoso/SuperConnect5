#import "Game.h"
#import "GlobalDefines.h"
#import "Move.h"
#import "Player.h"

@implementation Game

@synthesize delegate, players, moves, turn;

- (id) init {
	self = [super init];
	if (self != nil) {
		players = [[NSMutableArray alloc] init];
		moves = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)  startLocally{
	NSLog(@"Players:%i", [[self players] count] );
	int random = arc4random() % [players count];
	turn = [players objectAtIndex:random];
	[delegate game:self newStateActive:[turn local]];
}

-(void)tryToAddMoveInCell:(CGPoint)cell{
	NSLog(@"G: try to add move");

	// Is it a local player turn?
	if (![turn local]) return;
	
	// Is the cell empty?
	if ([self getMoveFromArrayWithCell:cell] != nil) return;
	NSLog(@"G: try to add move after checks");

	// Create and add object
	Move* move = [[Move alloc] init];
	[move setCell:cell];
	[move setOwner:turn];
	[moves addObject:move];
	
	// *** TODO: Should I broadcast this? ****

	// Lets get the next active player
	[self getNextActivePlayer];

	// Lets alert the new state to the VC
	[delegate game:self newStateActive:[turn local]];
	// Lets alert the new move to the VC
	[delegate game:self newMove:move];

	// Clean up
	[move release];
}

-(void)getNextActivePlayer{
	int position = [players indexOfObject:turn] + 1;
	if (position == [players count]) {
		position = 0;
	}
	turn = [players objectAtIndex:position];
}

- (Move*)getMoveFromArrayWithCell:(CGPoint)cell{
	for (Move* m in moves) {
		if (m.cell.x == cell.x && m.cell.y == cell.y) {
			return m;
		}
	}
	return nil;
}

-(void)checkForWin{
	BOOL win = NO;
	for (Move* m in moves) {
		// DERECHA
		for (int i = 0; i < FIVE; i++) {
			Move *n = [self getMoveFromArrayWithCell:CGPointMake(m.cell.x + i, m.cell.y)];
			if (n == nil) break;
			if ([n owner] != [m owner]) break;
			if (i == FIVE - 1) win = YES;
			
		}
		
		// ABAJO
		for (int i = 0; i < FIVE; i++) {
			Move *n = [self getMoveFromArrayWithCell:CGPointMake(m.cell.x , m.cell.y + i)];
			if (n == nil) break;
			if ([n owner] != [m owner]) break;
			if (i == FIVE - 1) win = YES;
			
		}
		
		// ABAJO DERECHA
		for (int i = 0; i < FIVE; i++) {
			Move *n = [self getMoveFromArrayWithCell:CGPointMake(m.cell.x + i , m.cell.y + i)];
			if (n == nil) break;
			if ([n owner] != [m owner]) break;
			if (i == FIVE - 1) win = YES;
			
		}
		
		// ABAJO IZQUIERDA
		for (int i = 0; i < FIVE; i++) {
			Move *n = [self getMoveFromArrayWithCell:CGPointMake(m.cell.x - i , m.cell.y + i)];
			if (n == nil) break;
			if ([n owner] != [m owner]) break;
			if (i == FIVE - 1) win = YES;
			
		}
	}
	
	[delegate game:self playerJustWon:turn];
}

- (void) dealloc{
	[moves release];
	[players release];
	[super dealloc];
}


@end

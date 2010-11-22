#import "GameViewController.h"
#import "GlobalDefines.h"
#import "GameBoard.h"
#import "Game.h"
#import "Move.h"
#import "Player.h"
#import "ResultViewController.h"

@implementation GameViewController

@synthesize localPlayers, computerPlayers, networkPlayers;

- (void) viewDidLoad{
	[headerActive setHidden:YES];
	/* ***** TODO ADD Player Image to header;  ******* */

	// Crear game board
	gameBoard = [[GameBoard alloc] initWithFrame:CGRectMake(0, 0, BOARD_SIZE * CELL_SIZE, BOARD_SIZE * CELL_SIZE)];
	[gameBoard setBackgroundColor:[UIColor whiteColor]];
	[gameBoard setDelegate:self];

	// Make the scrollview have the gameBoard subview
	[scrollView addSubview:gameBoard];
	[scrollView setUserInteractionEnabled:YES];
	[scrollView setContentSize:gameBoard.frame.size];
	[scrollView setContentOffset:CGPointMake(BOARD_SIZE*CELL_SIZE / 2, BOARD_SIZE*CELL_SIZE /2)];
	
	// Create game Object, set myself as delegate, set the correct info on it.
	game = [[Game alloc] init];
	[game setDelegate:self];
	
	// IF WE HAVE 0 NETWORK GUYS, its a local game, lets start it as such
	if (networkPlayers == 0) {
		// Create local players
		for (int i = 0; i < localPlayers; i++) {

			Player* p = [[Player alloc] init];
			[p setLocal:YES];
			[p setName:[NSString stringWithFormat:@"Player %i", i + 1]];
			[p setImage:[UIImage imageNamed:[Player getHardCodedImageForIndex:i]]];
			[[game players] addObject:p];
			[p release];
		}
		
		// ********TODO TODO Create computers for each computer

		[game startLocally];
	} else {
		// ********TODO TODO HERE YOU HAVE TO see if you are the lowest, if so, activate database(errr, master server script)
	}
	
}

- (void) centerToMove:(Move*)m{
	[scrollView setContentOffset:CGPointMake(m.cell.x * CELL_SIZE - (self.view.frame.size.width)/2, m.cell.y* CELL_SIZE - (self.view.frame.size.height)/2) animated:YES];
}

#pragma mark GameBoard PROTOCOL
- (void) clickedOnCell: (CGPoint)cell{
	[game tryToAddMoveInCell:cell];
}
#pragma mark -

#pragma mark GAME PROTOCOL
- (void) game:(Game*)game playerJustWon:(Player*)player{
	ResultViewController *c = [[ResultViewController alloc] init];
	[c setWinner:player];
	[[self navigationController] pushViewController:c animated:YES];
	[c release];	
}

- (void) game:(Game*)g newStateActive:(BOOL)active{
	[headerActive setHidden:!active];
	[headerLabel setText:[[game turn] name]];
}

- (void) game:(Game*)game newMove:(Move*)move{
	[gameBoard addMove:move];
	[self centerToMove:move];
}
#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	[game release];
	[gameBoard release];
    [super dealloc];
}

@end
#import "GameViewController.h"
#import "GlobalDefines.h"
#import "GameBoard.h"
#import "Game.h"
#import "Move.h"
#import "Player.h"
#import "ResultViewController.h"

@implementation GameViewController

@synthesize localPlayers, computerPlayers, networkPlayers;

GKMatch* myMatch;

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
		
		for (int i = 0; i < computerPlayers; i++) {
			Player* p = [[Player alloc] init];
			[p setComputer:YES];
			[p setName:[NSString stringWithFormat:@"Computer %i", i + 1]];
			[p setImage:[UIImage imageNamed:[Player getHardCodedImageForIndex:i + localPlayers]]];
			[[game players] addObject:p];
			[p release];
		}
		
		[game startLocally];
		[turnImageView setImage:[[game turn] image]];
	} else {
		GKMatchRequest *request = [[[GKMatchRequest alloc] init] autorelease];
		request.minPlayers = localPlayers + networkPlayers;
		request.maxPlayers = localPlayers + networkPlayers;
		
		GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithMatchRequest:request] autorelease];
		mmvc.matchmakerDelegate = self;
		
		[self presentModalViewController:mmvc animated:YES];
		overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
		[overlay setBackgroundColor:[UIColor redColor]];
		[[self view] bringSubviewToFront:overlay];
		[[self view] addSubview:overlay];
		
		// ********TODO TODO HERE YOU HAVE TO see if you are the lowest, if so, activate database(errr, master server script)
	}
	
}

#pragma mark matchmakerViewController 
- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController{
    [self dismissModalViewControllerAnimated:YES];
	[[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
	[[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)match{
    [self dismissModalViewControllerAnimated:YES];
	
    myMatch = match;
	[myMatch retain];
	[myMatch setDelegate:self];	
}
#pragma -
#pragma mark Match 
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
	// if its the handshake
	NSMutableDictionary *p = (NSMutableDictionary*)[NSKeyedUnarchiver unarchiveObjectWithData:data];

	if ([[p valueForKey:@"action"] isEqualToString:@"players"]) {
		for (NSDictionary *playerD in [p valueForKey:@"players"]) {
			Player* p = [[Player alloc] init];
			NSString *name = [playerD valueForKey:@"name"];
			if ([name isEqualToString:[[GKLocalPlayer localPlayer] alias]]) {
				[p setLocal:YES];
			} else {
				[p setLocal:NO];
			}
			[p setName:name];
			[p setImage:[UIImage imageNamed:[Player getHardCodedImageForIndex:[[game players] count]]]];
			[[game players] addObject:p];
			[p release];
		}
		[self startNetworkGame];
	}
	
	if ([[p valueForKey:@"action"] isEqualToString:@"move"]) {
		[game addMove:CGPointFromString([p valueForKey:@"cell"])];
	}

}


- (void)match:(GKMatch *)match player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state {
    switch (state){
        case GKPlayerStateConnected:
            // handle a new player connection.
			break;
        case GKPlayerStateDisconnected:
            // a player just disconnected.
			break;
    }
	
    if (!matchStarted && match.expectedPlayerCount == 0){
        matchStarted = YES;
		// Take a random number and send it to everyone.
		// IF WE ARE THE ONE, RUN THE NETWORK SETUP!!!
		
		BOOL theOne = YES;
		NSUInteger local = [[[GKLocalPlayer localPlayer] playerID] hash];
		for (NSString* playerId in [match playerIDs]) {
			if (local > [playerID hash]) {
				theOne = NO;
			}
		}
		
		if (theOne) {
			[self networkInit];
		}
    }
}
#pragma mark -

- (void) networkInit{
	// Create myself
	Player* p = [[Player alloc] init];
	[p setLocal:YES];
	[p setName:[[GKLocalPlayer localPlayer] alias]];
	[p setImage:[UIImage imageNamed:[Player getHardCodedImageForIndex:0]]];
	[[game players] addObject:p];
	[p release];

	// Create other players
	// TODO TODO TODO MAKE THIS LOAD ALL INSTEAD OF EACH COZ GK PLAYER CAN GET PLAYERSIDS NOT PLAYERID ONLY
	[GKPlayer loadPlayersForIdentifiers:[myMatch playerIDs] withCompletionHandler:^(NSArray *players, NSError *error) {
		if (error != nil){
			// Handle the error.
			// We should probably quit here or something
		}
		if (players != nil){
			for (GKPlayer *player in players) {
				Player* p = [[Player alloc] init];
				[p setLocal:NO];
				[p setName:[player alias]];
				[p setImage:[UIImage imageNamed:[Player getHardCodedImageForIndex:[[game players] count]]]];
				[[game players] addObject:p];
				[p release];
			}
			[self networkInitAddedAnotherPlayerToTheArray];	
		}
	}];
	
	
	// Create players array
}

- (void) networkInitAddedAnotherPlayerToTheArray{
	if ([[game players] count] != localPlayers + networkPlayers) return;
	[[game players] shuffle];
	[turnImageView setImage:[[game turn] image]];
	
	// Send players array to everyone
	[self sendPlayerArray];
	[self startNetworkGame];
}

- (void) startNetworkGame{
	[game startNetworkedGame];
	[overlay removeFromSuperview];		 
}

- (void) sendMoveToNetwork:(Move*)m{
	NSMutableDictionary* packetD = [[NSMutableDictionary alloc] init];
	[packetD setValue:@"move" forKey:@"action"];
	[packetD setValue:NSStringFromCGPoint([m cell]) forKey:@"cell"];

	
	NSData *packet = [NSKeyedArchiver archivedDataWithRootObject:packetD];
	
	NSError *error;
    [myMatch sendDataToAllPlayers: packet withDataMode: GKMatchSendDataReliable error:&error];
    if (error != nil){ NSLog(@"Failed to send"); }
	[packetD release];	
	
}

- (void) sendPlayerArray{
	NSMutableDictionary* packetD = [[NSMutableDictionary alloc] init];
	[packetD setValue:@"players" forKey:@"action"];
	
	NSMutableArray *players = [[NSMutableArray alloc] init];
	for (Player* p in [game players]) {
		NSMutableDictionary* playerD = [[NSMutableDictionary alloc] init];
		[playerD setValue:[p name] forKey:@"name"];
		[players addObject:playerD];
	}

	[packetD setValue:players forKey:@"players"];
	
	NSData *packet = [NSKeyedArchiver archivedDataWithRootObject:packetD];
	
	NSError *error;
    [myMatch sendDataToAllPlayers: packet withDataMode: GKMatchSendDataReliable error:&error];
    if (error != nil){ NSLog(@"Failed to send"); }
	[packetD release];	
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
	ResultViewController *c;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		c = [[ResultViewController alloc] initWithNibName:@"ResultViewController-iPad" bundle:nil];
	} else {
		c = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
	}

	[c setWinner:player];
	[[self navigationController] pushViewController:c animated:YES];
	[c release];	
}

- (void) game:(Game*)g newStateActive:(BOOL)active{
	[headerActive setHidden:!active];
	[headerLabel setText:[[game turn] name]];
}

- (void) game:(Game*)game newMove:(Move*)move{
	[turnImageView setImage:[[game turn] image]];
	[gameBoard addMove:move];
	if (networkPlayers > 0 && [[move owner] local] == YES) {
		[self sendMoveToNetwork:move];
	}
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
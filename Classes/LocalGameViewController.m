#import "LocalGameViewController.h"
#import "GameViewController.h"

@implementation LocalGameViewController

- (void) viewDidLoad{
	[localPlayersLabel setText:[NSString stringWithFormat:@"%i",(int)[localPlayersSlider value]]];
	[computerPlayersLabel setText:[NSString stringWithFormat:@"%i",(int)[computerPlayersSlider value]]];
	[self checkCanStart];
}

-(IBAction) backToMenu:(id)sender{
	[[self navigationController] popToRootViewControllerAnimated:YES];
}

-(IBAction) startGame:(id)sender{
	GameViewController *gameVC;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		gameVC = [[GameViewController alloc] initWithNibName:@"GameViewController-iPad" bundle:nil];
	} else {
		gameVC = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
	}
	[gameVC setLocalPlayers:(int)[localPlayersSlider value]];
	[gameVC setComputerPlayers:(int)[computerPlayersSlider value]];
	
	// FEED N LOCAL PLAYERS
	// FEED N COMPUTERS

/*
	TODO TODO TODO TODO 
	 -> FEED COMPUTERS LEVEL
	 -> FEED ROUNDS
	 -> FEED NUMBER OF 5 CONNECTS
*/

	// GO
	[[self navigationController] pushViewController:gameVC animated:YES];
	[gameVC release];
}

- (void) checkCanStart{
	int total = (int)[localPlayersSlider value] + (int)[computerPlayersSlider value];
	if (total > 1) {
		[startButton setEnabled:YES];
	} else {
		[startButton setEnabled:NO];
	}

}

-(IBAction) localPlayerSliderChanged:(id)sender{
	[localPlayersLabel setText:[NSString stringWithFormat:@"%i",(int)[localPlayersSlider value]]];
	[self checkCanStart];
}

-(IBAction) computerPlayerSliderChanged:(id)sender{
	[computerPlayersLabel setText:[NSString stringWithFormat:@"%i",(int)[computerPlayersSlider value]]];
	[self checkCanStart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

@end
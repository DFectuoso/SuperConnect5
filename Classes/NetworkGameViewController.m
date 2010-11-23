#import "NetworkGameViewController.h"
#import "GameViewController.h"

@implementation NetworkGameViewController

-(IBAction) oneVsOneGameStart:(id)sender{
	GameViewController *gameVC = [[GameViewController alloc] init];
	[gameVC setLocalPlayers:1];
	[gameVC setNetworkPlayers:1];

	[[self navigationController] pushViewController:gameVC animated:YES];
	[gameVC release];
}

-(IBAction) fourFFAGameStart:(id)sender{
	GameViewController *gameVC = [[GameViewController alloc] init];
	[gameVC setLocalPlayers:1];
	[gameVC setNetworkPlayers:3];
	
	[[self navigationController] pushViewController:gameVC animated:YES];
	[gameVC release];	
}

-(IBAction) backToMenu:(id)sender{
	[[self navigationController] popToRootViewControllerAnimated:YES];
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
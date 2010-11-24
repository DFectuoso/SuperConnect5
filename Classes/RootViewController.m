#import "RootViewController.h"
#import "ShopViewController.h"
#import "StatsViewController.h"
#import "LocalGameViewController.h"
#import "NetworkGameViewController.h"

@implementation RootViewController

-(IBAction) goToLocalGame:(id)sender{

	LocalGameViewController *c;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		c = [[LocalGameViewController alloc] initWithNibName:@"LocalGameViewController-iPad" bundle:nil];
	} else {
		c = [[LocalGameViewController alloc] initWithNibName:@"LocalGameViewController" bundle:nil];
	}
	[[self navigationController] pushViewController:c animated:YES];
	[c release];
}

-(IBAction) goToNetworkGame:(id)sender{
	// TODO Show a overlay

	[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		if (error == nil) {
			NetworkGameViewController *c;
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
				c = [[NetworkGameViewController alloc] initWithNibName:@"NetworkGameViewController-iPad" bundle:nil];
			} else {
				c = [[NetworkGameViewController alloc] initWithNibName:@"NetworkGameViewController" bundle:nil];
			}
			[[self navigationController] pushViewController:c animated:YES];
			[c release];	
		} else {
			NSLog(@"Lolz");
			// Hide overlay
		}
	}];
}

// We might want to show/do this only if we have a logged in user that has already played.
-(IBAction) goToShop:(id)sender{
	ShopViewController *c = [[ShopViewController alloc] init];
	[[self navigationController] pushViewController:c animated:YES];
	[c release];	
}

-(IBAction) goToStats:(id)sender{
	StatsViewController *c = [[StatsViewController alloc] init];
	[[self navigationController] pushViewController:c animated:YES];
	[c release];	
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
#import "RootViewController.h"
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
			// Your application can process the error parameter to report the error to the player.
		}
	}];
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
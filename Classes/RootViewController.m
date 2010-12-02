#import "RootViewController.h"
#import "LocalGameViewController.h"
#import "NetworkGameViewController.h"
#import "GameViewController.h"

@implementation RootViewController

-(void) viewDidLoad{
	/*
	[GKMatchmaker sharedMatchmaker].inviteHandler = ^(GKInvite *acceptedInvite, NSArray *playersToInvite) {
		// Insert application-specific code here to clean up any games in progress.
		
		if (acceptedInvite) {
			GameViewController *gameVC;
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
				gameVC = [[GameViewController alloc] initWithNibName:@"GameViewController-iPad" bundle:nil];
			} else {
				gameVC = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
			}
			
			[gameVC setLocalPlayers:1];
			[gameVC setNetworkPlayers:1];
			
			[[self navigationController] pushViewController:gameVC animated:YES];
			GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithInvite:acceptedInvite] autorelease];
			mmvc.matchmakerDelegate = gameVC;
			
			[gameVC presentModalViewController:mmvc animated:YES];
			[gameVC release];
		}
	};
	 */	
	
	overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[overlay setAlpha:0.3];
	[overlay setBackgroundColor:[UIColor blackColor]];
	[[self view] addSubview:overlay];
	
	activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[activityIndicator setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2.0)]; // I do this because I'm in landscape mode

	[self.view addSubview:activityIndicator]; // spinner is not visible until started	
	[[self view] addSubview:activityIndicator];
	
	[self hideActivityIndicator];
}

-(void)hideActivityIndicator{
	[overlay setHidden:YES];
	[activityIndicator setHidden:YES];
	[activityIndicator stopAnimating];
}

-(void)showActivityIndicator{
	[overlay setHidden:NO];
	[activityIndicator setHidden:NO];
	[activityIndicator startAnimating];
}

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
	[self showActivityIndicator];
	
	[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		[self hideActivityIndicator];
		if (error == nil) {
			NetworkGameViewController *c;
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
				c = [[NetworkGameViewController alloc] initWithNibName:@"NetworkGameViewController-iPad" bundle:nil];
			} else {
				c = [[NetworkGameViewController alloc] initWithNibName:@"NetworkGameViewController" bundle:nil];
			}
			[[self navigationController] pushViewController:c animated:YES];
			[c release];	
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
	[overlay release];
	[activityIndicator release];
    [super dealloc];
}

@end
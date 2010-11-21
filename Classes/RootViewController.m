#import "RootViewController.h"
#import "ShopViewController.h"
#import "StatsViewController.h"
#import "LocalGameViewController.h"
#import "NetworkGameViewController.h"

@implementation RootViewController

-(IBAction) goToLocalGame:(id)sender{
	LocalGameViewController *c = [[LocalGameViewController alloc] init];
	[[self navigationController] pushViewController:c animated:YES];
	[c release];
}

-(IBAction) goToNetworkGame:(id)sender{
	NetworkGameViewController *c = [[NetworkGameViewController alloc] init];
	[[self navigationController] pushViewController:c animated:YES];
	[c release];	
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
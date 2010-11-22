#import "ResultViewController.h"

@implementation ResultViewController

@synthesize winner;

-(IBAction) backToMenu:(id)sender{
	[[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void) viewDidLoad{
	[playerImage setImage:[[self winner] image]];
	[playerLabel setText: [[self winner] name]];
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
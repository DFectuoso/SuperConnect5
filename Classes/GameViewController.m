#import "GameViewController.h"


@implementation GameViewController

@synthesize localPlayers, computerPlayers, networkPlayers;

- (void) viewDidLoad{
	NSLog(@"SUP Local %i", localPlayers);
	NSLog(@"SUP Com %i", computerPlayers);
	NSLog(@"SUP Net %i", networkPlayers);
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
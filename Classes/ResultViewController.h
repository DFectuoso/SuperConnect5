#import <UIKit/UIKit.h>

@class Player;

@interface ResultViewController : UIViewController {
	IBOutlet UILabel *playerLabel;
	IBOutlet UIImageView *playerImage;
	
	Player *winner;
}

@property (nonatomic, retain) Player *winner;

-(IBAction) backToMenu:(id)sender;

@end

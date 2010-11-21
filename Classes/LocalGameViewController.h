//
//  LocalGameViewController.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LocalGameViewController : UIViewController {
	IBOutlet UISlider *localPlayersSlider;
	IBOutlet UILabel *localPlayersLabel;

	IBOutlet UISlider *computerPlayersSlider;
	IBOutlet UILabel *computerPlayersLabel;
	
	IBOutlet UIButton *startButton;
}

-(IBAction) backToMenu:(id)sender;
-(IBAction) startGame:(id)sender;

-(IBAction) localPlayerSliderChanged:(id)sender;
-(IBAction) computerPlayerSliderChanged:(id)sender;

- (void) checkCanStart;

@end

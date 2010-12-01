//
//  RootViewController.h
//  SuperConnect5
//
//  Created by Santiago Zavala on 11/21/10.
//  Copyright 2010 Twirex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface RootViewController : UIViewController {
	UIView *overlay;
	UIActivityIndicatorView *activityIndicator;
}

-(IBAction) goToLocalGame:(id)sender;
-(IBAction) goToNetworkGame:(id)sender;
-(void)showActivityIndicator;
-(void)hideActivityIndicator;

@end

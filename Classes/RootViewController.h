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

}

-(IBAction) goToLocalGame:(id)sender;
-(IBAction) goToNetworkGame:(id)sender;

// We might want to show/do this only if we have a logged in user that has already played.
-(IBAction) goToShop:(id)sender;
-(IBAction) goToStats:(id)sender;

@end

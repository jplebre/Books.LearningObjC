//
//  GameViewController.h
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerBullet.h"
#import "Enemy.h"

@interface GameViewController : UIViewController
@property UIImageView *bulletView;

- (IBAction)moveLeft:(id)sender;
- (IBAction)moveRight:(id)sender;
- (IBAction)TouchRelease:(id)sender;
- (IBAction)fireButton:(id)sender;

@end

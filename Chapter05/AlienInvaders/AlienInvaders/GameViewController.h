//
//  GameViewController.h
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerObject.h"
#import "Enemy.h"

@interface GameViewController : UIViewController

@property (atomic, strong) NSTimer *moveTimer;
@property (atomic, strong) NSTimer *collisionTimer;
@property PlayerObject *playerOne;
@property UIView *playerView;
@property Enemy *enemies;
@property (strong) UIImageView *loadingView;

enum GAME_STATE{
    INITIALIZING = 1,
    PLAYING = 2,
    RELOADING = 3,
    ENDING = 4,
}; typedef enum GAME_STATE GameState;

@property GameState currentState;


- (IBAction)moveLeft:(id)sender;
- (IBAction)moveRight:(id)sender;
- (IBAction)TouchRelease:(id)sender;
- (IBAction)fireButton:(id)sender;

@end

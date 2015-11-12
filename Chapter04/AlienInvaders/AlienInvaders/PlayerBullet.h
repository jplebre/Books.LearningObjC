//
//  PlayerBullet.h
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PlayerBullet : NSObject
@property CGRect bulletRect;
@property UIImageView *bulletView;
@property UIView *gameView;

@property (strong) NSTimer *bulletTimer;

-(void) fireBullet: (UIView *) gameView: (UIImageView *) playerView;

@end

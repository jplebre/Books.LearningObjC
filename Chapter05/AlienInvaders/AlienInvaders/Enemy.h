//
//  Enemy.h
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EnemyBullet.h"

@interface Enemy : NSObject

@property UIView *gameView;
@property NSInteger minXPos;
@property NSInteger maxXPos;
@property NSMutableArray *enemyList;
@property NSTimer *enemyTimer;
@property NSTimer *enemyBulletTimer;
@property EnemyBullet *enemiesBullet;

-(Enemy *) initEnemies: (UIView *) gameView;
-(void) moveEnemies;
-(void) dropBomb;
-(void) startTimers;
-(void) stopTimers;

@end

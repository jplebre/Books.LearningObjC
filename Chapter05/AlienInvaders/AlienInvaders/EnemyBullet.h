//
//  EnemyBullet.h
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EnemyBullet : NSObject
@property CGRect bulletRect;
@property UIImageView *bulletView;
@property UIView *gameView;
@property BOOL isActive;
@property (strong) NSTimer *bulletTimer;

-(EnemyBullet *) fireBullet: (UIView *) gameView: (NSArray *) enemyList;

@end

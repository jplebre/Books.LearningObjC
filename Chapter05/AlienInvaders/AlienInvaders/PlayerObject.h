//
//  PlayerObject.h
//  AlienInvaders
//
//  Created by João Lebre on 17/11/2015.
//  Copyright © 2015 jplebre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PlayerObject : NSObject

@property UIView *gameView;
@property CGRect playerRect;
@property (strong) UIImage *playerImage;
@property (strong) UIImageView *playerView;

- (PlayerObject *) initPlayer:(UIView *) gameView;

-(void) movePlayerRight;
-(void) movePlayerLeft;
-(void) fireBullet;
-(UIView *) getPlayerView;

@end

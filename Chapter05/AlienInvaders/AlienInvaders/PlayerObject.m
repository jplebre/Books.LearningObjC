//
//  PlayerObject.m
//  AlienInvaders
//
//  Created by João Lebre on 17/11/2015.
//  Copyright © 2015 jplebre. All rights reserved.
//

#import "PlayerObject.h"
#import "PlayerBullet.h"

@implementation PlayerObject

-(PlayerObject *) initPlayer:(UIView *) gameView
{
    self.gameView = gameView;
    
    //Assign the playerImage object an image from directory
    self.playerImage = [UIImage imageNamed:@"ship.png"];
    
    //Create an image view with the image object setup above
    self.playerView = [[UIImageView alloc] initWithImage: self.playerImage];
    
    //Set up playerView boundaries, a rectangle to scale the image
    self.playerRect = CGRectMake(50,550,32,32);
    self.playerView.frame = self.playerRect;
    
    //display the image
    [self.gameView addSubview:self.playerView];
    
    return self;
}

-(UIView *) getPlayerView
{
    return self.playerView;
}

-(void) movePlayerRight
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if(self.playerRect.origin.x <= screenRect.size.width - self.playerRect.size.width - 10)
    {
        self.playerRect = CGRectOffset(self.playerRect, 3, 0);
        self.playerView.frame = self.playerRect;
    }
}

-(void) movePlayerLeft
{
    if(self.playerRect.origin.x >= 10){
        self.playerRect = CGRectOffset(self.playerRect, -3, 0);
        self.playerView.frame = self.playerRect;
    }
}

-(void) fireBullet
{
    [[[PlayerBullet alloc] init] fireBullet: self.gameView: self.playerView];
}






















@end

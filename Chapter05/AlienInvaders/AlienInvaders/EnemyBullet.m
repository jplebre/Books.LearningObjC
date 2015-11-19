//
//  EnemyBullet.m
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import "EnemyBullet.h"

@implementation EnemyBullet

-(EnemyBullet *) fireBullet:(UIView *) gameView:(NSArray *) enemyList{
    self.isActive = true;
    self.gameView = gameView;
    int randomEnemy = (int)random() % (int)enemyList.count;
    UIImageView *enemyView = enemyList[randomEnemy];
    
    UIImage *bombImage1 = [UIImage imageNamed:@"bullet.png"];
    
    int bulletWidth = 8;
    int bulletStartX = enemyView.frame.origin.x;
    
    //Make 2 images out of bombImage 1 using rect
    CGImageRef imageRef1 = CGImageCreateWithImageInRect([bombImage1 CGImage], CGRectMake(0, 0, 32, 64));
    CGImageRef imageRef2 = CGImageCreateWithImageInRect([bombImage1 CGImage], CGRectMake(33, 0, 32, 64));
    
    //Create an array with both images to be used for the animation
    NSMutableArray *bombArray = [[NSMutableArray alloc] init];
    [bombArray addObject:[UIImage imageWithCGImage:imageRef1]];
    [bombArray addObject:[UIImage imageWithCGImage:imageRef2]];
    
    //Create views from the array
    self.bulletRect = CGRectMake(bulletStartX, enemyView.frame.origin.y, bulletWidth, bulletWidth*2);
    self.bulletView = [[UIImageView alloc] initWithFrame: self.bulletRect];
    
    //Set start image and setup animations
    [self.bulletView setImage:[UIImage imageWithCGImage:imageRef2]];
    
    self.bulletView.animationImages = bombArray;
    self.bulletView.animationDuration = 0.3;
    
    //Bulet is fired, animation is triggered, and moved up in the screen:
    [self.gameView addSubview:self.bulletView];
    [self.bulletView startAnimating];
    self.bulletTimer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                                        target:self
                                                      selector:@selector(moveBullet)
                                                      userInfo:nil
                                                       repeats:YES];
    return self;
}

-(void)moveBullet{
    self.bulletRect = CGRectOffset(self.bulletRect, 0, 5);
    self.bulletView.frame = self.bulletRect;
    
    if (self.bulletRect.origin.y > 550){
        self.isActive = false;
        [self.bulletTimer invalidate];
        self.bulletTimer = nil;
        [self.bulletView removeFromSuperview];
    }
}

@end
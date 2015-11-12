//
//  Enemy.m
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

int eSize = 32;
bool goingLeft = false;
int enemyRows = 5;
int enemyColumns = 5;

-(void) initEnemies:(UIView *)gameView{
    self.minXPos = 10;
    self.maxXPos = 278;
    self.gameView = gameView;
    
    //keeping track of row number:
    int rowCount = 0;
    
    //create enemies from left/top
    int startX = 10;
    int startY = 0;
    
    //enemy image
    UIImage *enemyImage = [UIImage imageNamed:@"enemy01.png"];
    self.enemyList = [[NSMutableArray alloc] init];
    
    //loop to create enemies:
    for (int i = 0; i < (enemyRows * enemyColumns); i++){
        int columnModulo = i % enemyColumns;
        
        if (columnModulo == 0) rowCount++;
        
        //calculate frame position for enemy
        int xPos = startX + ((eSize*columnModulo) + (columnModulo*5));
        int yPos = startY + ((eSize*rowCount) + (rowCount*10));
        
        //Add image to enemy
        UIImageView *enemyView = [[UIImageView alloc] initWithImage:enemyImage];
        enemyView.frame = CGRectMake(xPos, yPos, eSize, eSize);
        
        //add new enemy to enemy list
        [self.enemyList addObject: enemyView];
        
        //display new enemy
        [self.gameView addSubview: enemyView];
    }
    
    self.enemyTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03
                                                       target: self
                                                     selector: @selector(moveEnemies)
                                                     userInfo: nil
                                                      repeats: YES];
    
    self.enemyBulletTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                             target: self
                                                           selector: @selector(dropBomb)
                                                           userInfo: nil
                                                            repeats: YES];
    
}

-(void) moveEnemies{
    UIImageView *enemyView = self.enemyList[0];
    
    if(enemyView.frame.origin.x <= self.minXPos) goingLeft = false;
    
    enemyView = self.enemyList [enemyColumns - 1];
    
    if(enemyView.frame.origin.x >= self.maxXPos) goingLeft = true;
    
    //Cycle through all enemies and move them right
    for (int i=0; i <self.enemyList.count; i++){
        enemyView = self.enemyList[i];
        int xPos;
        
        if (goingLeft){
            xPos = enemyView.frame.origin.x-3;
        }else{
            xPos = enemyView.frame.origin.x+3;
        }
        
        enemyView.frame = CGRectMake(xPos, enemyView.frame.origin.y, eSize, eSize);
        
        [self.gameView addSubview:enemyView];
    }
}

-(void) dropBomb{
    EnemyBullet *newBullet = [[EnemyBullet alloc] init];
    [newBullet fireBullet: self.gameView: self.enemyList];
}

@end

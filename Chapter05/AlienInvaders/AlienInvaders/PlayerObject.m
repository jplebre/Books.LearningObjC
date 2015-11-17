//
//  PlayerObject.m
//  AlienInvaders
//
//  Created by João Lebre on 17/11/2015.
//  Copyright © 2015 jplebre. All rights reserved.
//

#import "PlayerObject.h"

@implementation PlayerObject





















//Assign the playerImage object an image from directory
self.playerImage = [UIImage imageNamed:@"ship.png"];

//Create an image view with the image object setup above
self.playerView = [[UIImageView alloc] initWithImage: self.playerImage];

//Set up playerView boundaries, a rectangle to scale the image
self.playerRect = CGRectMake(50,550,32,32);
self.playerView.frame = self.playerRect;

//display the image
[self.view addSubview:self.playerView];

@end

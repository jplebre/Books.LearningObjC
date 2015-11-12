//
//  GameViewController.m
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property (strong) UIImage *playerImage;
@property (strong) UIImageView *playerView;
@property CGRect playerRect;

@property (strong) NSTimer *moveTimer;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Assign the playerImage object an image from directory
    self.playerImage = [UIImage imageNamed:@"ship.png"];
    
    //Create an image view with the image object setup above
    self.playerView = [[UIImageView alloc] initWithImage: self.playerImage];
    
    //Set up playerView boundaries, a rectangle to scale the image
    self.playerRect = CGRectMake(50,550,32,32);
    self.playerView.frame = self.playerRect;
    
    //display the image
    [self.view addSubview:self.playerView];
    
    //initialize Enemies
    [[[Enemy alloc] init] initEnemies: self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)moveLeft:(id)sender {
    [self releaseTouch];
    
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03
                                                      target: self
                                                    selector: @selector(movePlayerLeft)
                                                    userInfo: nil
                                                     repeats: YES];
}

- (void)movePlayerLeft {
    if(self.playerRect.origin.x >= 10){
        self.playerRect = CGRectOffset(self.playerRect, -3, 0);
        self.playerView.frame = self.playerRect;
    }
}

- (IBAction)moveRight:(id)sender {
    [self releaseTouch];
    
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03
                                                      target: self
                                                    selector: @selector(movePlayerRight)
                                                    userInfo: nil
                                                     repeats: YES];
}

- (void)movePlayerRight {
    if(self.playerRect.origin.x <= 320){
        self.playerRect = CGRectOffset(self.playerRect, 3, 0);
        self.playerView.frame = self.playerRect;
    }
}

- (IBAction)TouchRelease:(id)sender {
    [self releaseTouch];
}


- (void) releaseTouch {
    if (self.moveTimer != nil){
        [self.moveTimer invalidate];
        self.moveTimer = nil;
    }
}

- (IBAction)fireButton:(id)sender {
    [[[PlayerBullet alloc] init] fireBullet: self.view: self.playerView];
}

@end

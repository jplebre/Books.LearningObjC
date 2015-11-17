//
//  GameViewController.m
//  AlienInvaders
//
//  Created by João Pedro Lebre on 02/09/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()



@end

@implementation GameViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:<#nibNameOrNil#> bundle:<#nibBundleOrNil#>];
    if (self)
    {
        //
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerOne = [[[PlayerObject alloc]init] initPlayer:self.view];
    self.playerView = [self.playerOne getPlayerView];
    
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
                                                      target: self.playerOne
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
                                                      target: self.playerOne
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

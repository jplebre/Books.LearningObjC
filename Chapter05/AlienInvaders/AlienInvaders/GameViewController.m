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

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        //
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeState: INITIALIZING];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//--------------------------------------------------------------------------------------
// Controller

- (IBAction)moveLeft:(id)sender {
    [self releaseTouch];
    
    if (self.currentState != PLAYING)
        return;
    
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03
                                                      target: self.playerOne
                                                    selector: @selector(movePlayerLeft)
                                                    userInfo: nil
                                                     repeats: YES];
}

- (IBAction)moveRight:(id)sender {
    [self releaseTouch];
    
    if (self.currentState != PLAYING)
        return;
    
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03
                                                      target: self.playerOne
                                                    selector: @selector(movePlayerRight)
                                                    userInfo: nil
                                                     repeats: YES];
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
    if (self.currentState != PLAYING)
        return;
    
    [self.playerOne fireBullet];
}


//--------------------------------------------------------------------------------------
// Game states, changing between states

-(void)changeState: (int)newState{
    switch (newState)
    {
        case INITIALIZING:
            [self loadingScreen];
            break;
        case PLAYING:
            break;
        case RELOADING:
            [self.view addSubview:self.loadingView];
            [self.enemies stopTimers];
            [self.collisionTimer invalidate];
            self.collisionTimer = NULL;
            break;
        case ENDING:
            break;
        default:
            NSLog(@"GameState not found, integer out of range");
            break;
    }
    self.currentState = newState;
}

-(void)loadingScreen{
    self.playerOne = [[[PlayerObject alloc]init] initPlayer:self.view];
    self.playerView = [self.playerOne getPlayerView];
    
    self.enemies = [[[Enemy alloc] init] initEnemies: self.view];

    self.loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]];
    self.loadingView.frame = self.view.frame;
    
    [self.view addSubview:self.loadingView];
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(closeScreen)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)closeScreen{
    [self.loadingView removeFromSuperview];
    [self changeState:PLAYING];
    [self.enemies startTimers];
    self.collisionTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                           target:self
                                                         selector:@selector(intersectCheck)
                                                         userInfo:nil
                                                          repeats:YES];
}

-(void)endScreen{
    [self.loadingView removeFromSuperview];
    [self changeState:ENDING];
    [self performSegueWithIdentifier:@"unwind" sender:self];
}


//--------------------------------------------------------------------------------------
// Logic

-(void)intersectCheck{
    BOOL isConnecting = CGRectIntersectsRect(self.enemies.enemiesBullet.bulletRect, self.playerOne.playerRect);
    
    if (isConnecting == true){
        [NSTimer scheduledTimerWithTimeInterval:2
                                         target:self
                                       selector:@selector(endScreen)
                                       userInfo:nil
                                        repeats:NO];
        [self changeState:RELOADING];
    }
}



@end

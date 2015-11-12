//
//  GameSceneViewController.h
//  MemoryGame
//
//  Created by João Pedro Lebre on 15/08/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSceneViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonViews;
@property (strong, nonatomic) IBOutlet UILabel *gameScoreLabel;

- (IBAction)tileClicked:(id)sender;

@end

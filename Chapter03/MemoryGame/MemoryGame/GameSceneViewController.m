//
//  GameSceneViewController.m
//  MemoryGame
//
//  Created by João Pedro Lebre on 15/08/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import "GameSceneViewController.h"

@interface GameSceneViewController ()

//images to display
@property UIImage *blankTileImage;
@property UIImage *backTileImage;

//Images and shuffled tile images
@property NSMutableArray *tiles;
@property NSMutableArray *shuffledTiles;

//Counters
@property NSInteger matchCounter;
@property NSInteger guessCounter;

//ID number of the flipped tiles
@property NSInteger tileFlipped;
@property UIButton *tile1;
@property UIButton *tile2;


- (void) shuffleTiles;
- (void) resetTiles;
- (void) gameWon;

@end



@implementation GameSceneViewController

static bool lockTileFlipping = false;
static bool playIsMatch = false;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.backTileImage = [UIImage imageNamed:@"back.png"];
    self.blankTileImage = [UIImage imageNamed:@"blank.png"];
    
    //no tiles flipped yet, set to -1 so it's outside the 0-29 range
    self.tileFlipped = -1;
    
    //counters set to 0
    self.matchCounter = 0;
    self.guessCounter = 0;
    
    self.gameScoreLabel.text = [NSString stringWithFormat:@"Matches: %ld Guesses: %ld", self.matchCounter, self.guessCounter];
    
    self.tiles = [[NSMutableArray alloc] initWithObjects:
                  [UIImage imageNamed:@"icons01.png"],
                  [UIImage imageNamed:@"icons01.png"],
                  [UIImage imageNamed:@"icons02.png"],
                  [UIImage imageNamed:@"icons02.png"],
                  [UIImage imageNamed:@"icons03.png"],
                  [UIImage imageNamed:@"icons03.png"],
                  [UIImage imageNamed:@"icons04.png"],
                  [UIImage imageNamed:@"icons04.png"],
                  [UIImage imageNamed:@"icons05.png"],
                  [UIImage imageNamed:@"icons05.png"],
                  [UIImage imageNamed:@"icons06.png"],
                  [UIImage imageNamed:@"icons06.png"],
                  [UIImage imageNamed:@"icons07.png"],
                  [UIImage imageNamed:@"icons07.png"],
                  [UIImage imageNamed:@"icons08.png"],
                  [UIImage imageNamed:@"icons08.png"],
                  [UIImage imageNamed:@"icons09.png"],
                  [UIImage imageNamed:@"icons09.png"],
                  [UIImage imageNamed:@"icons10.png"],
                  [UIImage imageNamed:@"icons10.png"],
                  [UIImage imageNamed:@"icons11.png"],
                  [UIImage imageNamed:@"icons11.png"],
                  [UIImage imageNamed:@"icons12.png"],
                  [UIImage imageNamed:@"icons12.png"],
                  [UIImage imageNamed:@"icons13.png"],
                  [UIImage imageNamed:@"icons13.png"],
                  [UIImage imageNamed:@"icons14.png"],
                  [UIImage imageNamed:@"icons14.png"],
                  [UIImage imageNamed:@"icons15.png"],
                  [UIImage imageNamed:@"icons15.png"],
                  nil];
    
    [self shuffleTiles];
}

- (void) shuffleTiles
{
    NSUInteger tileCount = [self.tiles count];
    
    for (int tileID = 0; tileID < (tileCount/2); tileID++)
    {
        [self.shuffledTiles addObject: [NSNumber numberWithInt:tileID]];
        [self.shuffledTiles addObject: [NSNumber numberWithInt:tileID]];
    }
    
    for (NSUInteger i = 0; i < tileCount; i++)
    {
        NSInteger nElements = tileCount - i;
        NSInteger randomTileID = (arc4random() % nElements) + i;
        [self.shuffledTiles exchangeObjectAtIndex:i withObjectAtIndex: randomTileID];
        [self.tiles exchangeObjectAtIndex:i withObjectAtIndex:randomTileID];
    }
}

- (IBAction)tileClicked:(id)sender
{
    //if the clicks are disabled, exit method:
    if (lockTileFlipping == true)
    {
        return;
    }
    
    NSInteger senderID = [sender tag];
    
    if (self.tileFlipped >= 0 && senderID != self.tileFlipped)
    {
        self.tile2 = sender;
        
        UIImage *lastImage = [self.tiles objectAtIndex: self.tileFlipped];
        UIImage *tileImage = [self.tiles objectAtIndex: senderID];
        
        [sender setImage: tileImage forState: UIControlStateNormal];
        
        self.guessCounter++;
        NSLog(@"%@",tileImage);
        NSLog(@"%@",lastImage);

        if([tileImage imageAsset] == [lastImage imageAsset])
        {
            [self.tile1 setEnabled:false];
            [self.tile2 setEnabled:false];
            self.matchCounter++;
            playIsMatch = true;
        }
        
        lockTileFlipping = true;
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(resetTiles)
                                       userInfo:nil
                                        repeats:NO];
        self.tileFlipped = -1;
    }
    else
    {
        self.tileFlipped = senderID;
        self.tile1 = sender;
        
        UIImage *tileImage = [self.tiles objectAtIndex:senderID];
        [sender setImage:tileImage forState:UIControlStateNormal];
    }
    
    self.gameScoreLabel.text = [NSString stringWithFormat:@"Matches: %ld Guesses: %ld", self.matchCounter, self.guessCounter];
}


- (void) resetTiles
{
    if (playIsMatch)
    {
        [self.tile1 setImage:self.blankTileImage forState:UIControlStateNormal];
        [self.tile2 setImage:self.blankTileImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"no");
        [self.tile1 setImage:self.backTileImage forState:UIControlStateNormal];
        [self.tile2 setImage:self.backTileImage forState:UIControlStateNormal];
    }
    
    playIsMatch = false;
    lockTileFlipping = false;
    
    if (self.matchCounter == (self.tiles.count/2))
    {
        [self gameWon];
    }
}

- (void) gameWon
{
    self.gameScoreLabel.text = [NSString stringWithFormat:@"You won with %ld guesses!", self.guessCounter];
}

//Probably won't need this, but added to follow the book's instructions:
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

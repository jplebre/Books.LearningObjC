//
//  ViewController.m
//  HelloWorld2
//
//  Created by João Pedro Lebre on 14/08/2015.
//  Copyright (c) 2015 jplebre. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)showAlert{
    UIAlertView *helloWorldAlert = [[UIAlertView alloc]
                                    initWithTitle:@"The Awesome Hello World Window"
                                    message: @"Hello World 2!"
                                    delegate:nil
                                    cancelButtonTitle:@"OK"
                                    otherButtonTitles:@"LeaveMeAlone", nil];
    [helloWorldAlert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

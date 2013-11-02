//
//  CorpseViewController.m
//  Corpse
//
//  Created by Justin Bachorik on 11/2/13.
//  Copyright (c) 2013 Insanely Awesome. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "CorpseViewController.h"
#import "MenuScene.h"

@interface CorpseViewController ()

@end

@implementation CorpseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // spritekit setup
    SKView *spriteView = (SKView *) [self view];
    [spriteView setShowsDrawCount:YES];
    [spriteView setShowsNodeCount:YES];
    [spriteView setShowsFPS:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    MenuScene *menu = [[MenuScene alloc] initWithSize:CGSizeMake(768, 1024)]; // full-screen
    SKView *spriteView = (SKView *) [self view];
    [spriteView presentScene: menu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

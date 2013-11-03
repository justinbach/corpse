//
//  CorpseScene.m
//  Corpse
//
//  Created by Justin Bachorik on 11/3/13.
//  Copyright (c) 2013 Insanely Awesome. All rights reserved.
//

#import "CorpseScene.h"

@interface CorpseScene ()
@property BOOL contentCreated;
@end

@implementation CorpseScene
- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        [self setContentCreated:YES];
    }
}

- (void)createSceneContents
{
    [self setBackgroundColor:[SKColor colorWithWhite:1 alpha:1]];
    [self setScaleMode:SKSceneScaleModeAspectFit];
    [self addChild: [self newWinNode]];
}

- (SKLabelNode *)newWinNode
{
    SKLabelNode *winNode = [SKLabelNode labelNodeWithFontNamed:@"Emulogic"];
    [winNode setFontColor:[SKColor colorWithWhite:0 alpha:1]];
    [winNode setText:@"You Win!"];
    [winNode setFontSize:20];
    [winNode setPosition:CGPointMake(CGRectGetMidX([self frame]), CGRectGetMidY([self frame]))];
    return winNode;
}

@end

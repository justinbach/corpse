//
//  MenuScene.m
//  Corpse
//
//  Created by Justin Bachorik on 11/2/13.
//  Copyright (c) 2013 Insanely Awesome. All rights reserved.
//

#import "MenuScene.h"

@interface MenuScene ()
@property BOOL contentCreated;
@end

@implementation MenuScene

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
    [self setBackgroundColor:[SKColor blackColor]];
    [self setScaleMode:SKSceneScaleModeAspectFit];
    [self addChild: [self newMenuNode]];
}

- (SKLabelNode *)newMenuNode
{
    SKLabelNode *menuNode = [SKLabelNode labelNodeWithFontNamed:@"Emulogic"];
    [menuNode setText:@"You win!"];
    [menuNode setFontSize:20];
    [menuNode setPosition:CGPointMake(CGRectGetMidX([self frame]), CGRectGetMidY([self frame]))];
    return menuNode;
}

@end

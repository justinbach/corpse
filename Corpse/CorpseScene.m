//
//  CorpseScene.m
//  Corpse
//
//  Created by Justin Bachorik on 11/3/13.
//  Copyright (c) 2013 Insanely Awesome. All rights reserved.
//

#import "MenuScene.h"
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
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playAgainNode) userInfo:nil repeats:NO];


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

- (void)playAgainNode
{
    SKLabelNode *winNode = [SKLabelNode labelNodeWithFontNamed:@"Emulogic"];
    [winNode setFontColor:[SKColor colorWithWhite:0 alpha:1]];
    [winNode setText:@"Play Again?"];
    [winNode setFontSize:14];
    [winNode setName:@"playAgain"];
    [winNode setPosition:CGPointMake(CGRectGetMidX([self frame]), CGRectGetMidY([self frame])-150)];
    [winNode setAlpha:0];
    
    [self addChild: winNode];
    
    SKAction *fadeAway = [SKAction fadeInWithDuration:0.5];
    SKAction *zoomAndFade = [SKAction group:@[fadeAway]];
    SKAction *moveSequence = [SKAction sequence:@[zoomAndFade]];
    [winNode runAction:moveSequence ];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *menuNode = [self childNodeWithName:@"playAgain"];
    if (menuNode != nil)
    {
        [menuNode setName:nil];
        SKScene *menuScene = [[MenuScene alloc] initWithSize:[self size]];
        SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:0.75];
        [[self view] presentScene:menuScene transition:doors];

    }
}



@end

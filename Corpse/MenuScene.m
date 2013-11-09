//
//  MenuScene.m
//  Corpse
//
//  Created by Justin Bachorik on 11/2/13.
//  Copyright (c) 2013 Insanely Awesome. All rights reserved.
//

#import "MenuScene.h"
#import "CorpseScene.h"

@interface MenuScene ()
@property BOOL contentCreated;
@end

@implementation MenuScene

@synthesize menuNode, labelNode;

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
    if (! duration) {
        duration = 1.0;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(moveMenuNode) userInfo:nil repeats:YES];
    [self moveMenuNode];
}

- (void)moveMenuNode
{

    int w = labelNode.frame.size.width;
    int x = rand() % (int)([self size].width - w);
    int h = labelNode.frame.size.height;
    int y = rand() % (int)([self size].height - h);

    SKAction *moveX = [SKAction moveToX:(x+(w/2)) duration:duration];
    SKAction *moveY = [SKAction moveToY:(y) duration:duration];
    [labelNode runAction:[SKAction group:@[moveX, moveY]]];
}

- (SKLabelNode *)newMenuNode
{

    labelNode = [SKLabelNode labelNodeWithFontNamed:@"Emulogic"];

    [labelNode setText:@"Tap To Begin..."];
    [labelNode setFontSize:20];
    [labelNode setPosition:CGPointMake(CGRectGetMidX([self frame]), CGRectGetMidY([self frame]))];
    [labelNode setName:@"menuNode"];
    labelNode.name = @"labelNode";
    
    return labelNode;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain

    if ([node.name isEqualToString:@"labelNode"]) {
   
        [node setName:nil];
        SKAction *zoom = [SKAction scaleTo:20 duration:1];
        SKAction *moveDown = [SKAction moveByX:0 y:-100 duration:1];
        SKAction *fadeAway = [SKAction fadeOutWithDuration:1];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *zoomAndFade = [SKAction group:@[zoom, moveDown, fadeAway]];
        SKAction *moveSequence = [SKAction sequence:@[zoomAndFade, remove]];
        [node runAction:moveSequence completion:^{
            SKScene *corpseScene = [[CorpseScene alloc] initWithSize:[self size]];
            SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:0.5];
            [[self view] presentScene:corpseScene transition:doors];
        }];
                                
    }
    
    
}

@end

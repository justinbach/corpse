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

@synthesize targetNode;
@synthesize difficultyNode;

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
    [self setBackgroundColor:[self getRandomColor]];
    [self setScaleMode:SKSceneScaleModeAspectFit];
    [self addChild: [self newTargetNode]];
    if (! duration) {
        duration = 1.0;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(moveLabelNode) userInfo:nil repeats:YES];
    [self moveLabelNode];
}

- (void)moveLabelNode
{

    int w = targetNode.frame.size.width;
    int x = rand() % (int)([self size].width - w);
    int h = targetNode.frame.size.height;
    int y = rand() % (int)([self size].height - h);

    SKAction *moveX = [SKAction moveToX:(x+(w/2)) duration:duration];
    SKAction *moveY = [SKAction moveToY:(y) duration:duration];
    [targetNode runAction:[SKAction group:@[moveX, moveY]]];
}

- (SKLabelNode *)newDifficultyNode
{

//    targetNode = [SKLabelNode labelNodeWithFontNamed:@"Emulogic"];
//
//    [targetNode setText:@"Catch me if you can"];
//    [targetNode setFontSize:20];
//    [targetNode setPosition:CGPointMake(CGRectGetMidX([self frame]), CGRectGetMidY([self frame]))];
//    targetNode.name = @"targetNode";
//    
//    return targetNode;
    return nil;
}

- (SKSpriteNode *)newTargetNode
{
    targetNode = [[SKSpriteNode alloc] initWithColor:[self getRandomColor] size:CGSizeMake(100, 100)];
    [targetNode setName:@"targetNode"];
    
    return targetNode;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain

    if ([node.name isEqualToString:@"targetNode"]) {
        NSLog(@"Yup");
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

- (UIColor *)getRandomColor
{
    float r = [self getRandomFloat];
    float g = [self getRandomFloat];
    float b = [self getRandomFloat];
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

#define ARC4RANDOM_MAX      0x100000000
- (float)getRandomFloat
{
    return ((double)arc4random() / ARC4RANDOM_MAX);;
}

@end

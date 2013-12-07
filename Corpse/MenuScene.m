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
@synthesize infoNode;

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
    [self addChild: [self newInfoNode]];
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
    SKAction *moveY = [SKAction moveToY:(y+(h/2)) duration:duration]; // why the hell is this exceeding the scene bounds?
    [targetNode runAction:[SKAction group:@[moveX, moveY]]];
}

- (SKNode *)newInfoNode
{
    infoNode = [[SKNode alloc] init];
    SKLabelNode *instructionsNode = [SKLabelNode labelNodeWithFontNamed:@"Emulogic"];
    [instructionsNode setText:@"can you tap the box?"];
    [instructionsNode setFontSize:20];
    
    
    SKLabelNode *difficultyNode = [SKLabelNode labelNodeWithFontNamed:@"Emulogic"];
    [difficultyNode setText:[@"difficulty: " stringByAppendingString:[self getDifficultyText]]];
    [difficultyNode setFontSize:14];
    [difficultyNode setPosition:CGPointMake(0, -1 * ([instructionsNode frame].size.height) - 10)];
    
    NSArray *labelNodes = @[instructionsNode, difficultyNode];
    for (SKLabelNode *labelNode in labelNodes) {
        [labelNode setFontColor:[self isBackgroundLight] ? [UIColor blackColor] : [UIColor whiteColor]];
    }
    
    [infoNode addChild:instructionsNode];
    [infoNode addChild:difficultyNode];
    [infoNode setPosition:CGPointMake(CGRectGetMidX([self frame]), CGRectGetMaxY([self frame]) - 210)];
    
    return infoNode;
}

- (SKSpriteNode *)newTargetNode
{
    targetNode = [[SKSpriteNode alloc] initWithColor:[self getRandomColor] size:CGSizeMake(50, 50)];
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

- (BOOL)isBackgroundLight
{
    const CGFloat *components = CGColorGetComponents([[self backgroundColor] CGColor]);
    float r = components[0];
    float g = components[1];
    float b = components[2];
    return (r + g + b > 1.5);
}

// returns the percentage of difference between bg color and target color
- (float)getDifficultyScore
{
    // using naive Euclidean comparison here, sorry guys
    const CGFloat *bgComponents = CGColorGetComponents([[self backgroundColor] CGColor]);
    float bgR = bgComponents[0];
    float bgG = bgComponents[1];
    float bgB = bgComponents[2];
    
    const CGFloat *tComponents = CGColorGetComponents([[targetNode color] CGColor]);
    float tR = tComponents[0];
    float tG = tComponents[1];
    float tB = tComponents[2];
    
    float distance = sqrtf(powf((bgR - tR), 2) +
                           powf((bgG - tG), 2) +
                           powf((bgB - tB), 2));
    return distance / sqrtf(3.0);
}

- (NSString *)getDifficultyText
{
    float difference = [self getDifficultyScore];
    NSString *difficultyMessage;
    if (difference < .1) {
        difficultyMessage = @"insane";
    } else if (difference < .3) {
        difficultyMessage = @"hard";
    } else if (difference < .5) {
        difficultyMessage = @"moderate";
    } else if (difference < .7) {
        difficultyMessage = @"easy";
    } else {
        difficultyMessage = @"too easy";
    }
    
    return difficultyMessage;
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

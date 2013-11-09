//
//  MenuScene.h
//  Corpse
//
//  Created by Justin Bachorik on 11/2/13.
//  Copyright (c) 2013 Insanely Awesome. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MenuScene : SKScene {
    SKSpriteNode *menuNode;
    SKLabelNode *labelNode;
    float duration;
}

@property (nonatomic, retain) SKSpriteNode *menuNode;
@property (nonatomic, retain) SKLabelNode *labelNode;

@end

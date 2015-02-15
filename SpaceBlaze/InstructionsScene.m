//
//  InstructionsScene.m
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-10.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import "InstructionsScene.h"
#import "MenuScene.h"

@implementation InstructionsScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKLabelNode *instructionsHeaderLabel = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsHeaderLabel.text = @"Instructions";
        instructionsHeaderLabel.fontSize = 30;
        instructionsHeaderLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.85);
        instructionsHeaderLabel.fontColor = [SKColor whiteColor];
        [self addChild:instructionsHeaderLabel];
        
        //TODO: Separate instuctions into lines.
        SKLabelNode *instructionsLabel1 = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel1.text = @"Dodge the comets to stay alive.";
        instructionsLabel1.fontSize = 20;
        instructionsLabel1.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.6);
        instructionsLabel1.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel1];
        
        SKLabelNode *instructionsLabel2 = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel2.text = @"Drag your finger to move.";
        instructionsLabel2.fontSize = 20;
        instructionsLabel2.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.5);
        instructionsLabel2.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel2];
        
        SKLabelNode *instructionsLabel3 = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel3.text = @"Achieve a high score!";
        instructionsLabel3.fontSize = 20;
        instructionsLabel3.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.4);
        instructionsLabel3.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel3];
        
        SKLabelNode *instructionsLabel4 = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel4.text = @"How long can you survive?";
        instructionsLabel4.fontSize = 20;
        instructionsLabel4.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.3);
        instructionsLabel4.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel4];
        
        SKLabelNode *backButton = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        backButton.text = @"Back";
        backButton.fontSize = 20;
        backButton.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.15);
        backButton.fontColor = [SKColor whiteColor];
        backButton.name = @"backButton";
        [self addChild:backButton];
    }
    return self;
}

- (void)backToMenu
{
    MenuScene *menuScene = [[MenuScene alloc] initWithSize:self.size];
    [self.view presentScene:menuScene transition:[SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.5]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    SKNode *touchNode = [self nodeAtPoint:touchLocation];
    
    if ([touchNode.name isEqualToString:@"backButton"]) {
        [self backToMenu];
    }
}

@end

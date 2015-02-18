//
//  InstructionsScene.m
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-10.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import "InstructionsScene.h"
#import "MenuScene.h"
#import "GameScene.h"

@implementation InstructionsScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKEmitterNode *background = [SKEmitterNode ball_emitterNamed:@"BlazeParticle"];
        background.particlePositionRange = CGVectorMake(self.size.width*2, self.size.height*2);
        [background advanceSimulationTime:100];
        [self addChild:background];
        
        SKLabelNode *instructionsHeaderLabel = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsHeaderLabel.text = @"Instructions";
        instructionsHeaderLabel.fontSize = 30;
        instructionsHeaderLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.85);
        instructionsHeaderLabel.fontColor = [SKColor whiteColor];
        [self addChild:instructionsHeaderLabel];
        
        SKLabelNode *instructionsLabel1 = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel1.text = @"Dodge the comets to stay alive.";
        instructionsLabel1.fontSize = 20;
        instructionsLabel1.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.65);
        instructionsLabel1.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel1];
        
        SKLabelNode *instructionsLabel2 = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel2.text = @"Drag your finger to move.";
        instructionsLabel2.fontSize = 20;
        instructionsLabel2.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.55);
        instructionsLabel2.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel2];
        
        SKLabelNode *instructionsLabel3 = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel3.text = @"Achieve a high score!";
        instructionsLabel3.fontSize = 20;
        instructionsLabel3.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.45);
        instructionsLabel3.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel3];
        
        SKLabelNode *instructionsLabel4 = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel4.text = @"How long can you survive?";
        instructionsLabel4.fontSize = 20;
        instructionsLabel4.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.35);
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
    [self.view presentScene:menuScene transition:[SKTransition doorsCloseVerticalWithDuration:0.5]];
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

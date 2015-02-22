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
        int fontSize;
        if (self.frame.size.width < 330) {          //iPhone 4S, 5, 5S
            fontSize = 28;
        } else if (self.frame.size.width < 380) {   //iPhone 6
            fontSize = 32;
        } else if (self.frame.size.width < 420) {   //iPhone 6 Plus
            fontSize = 35;
        } else {                                    //iPad
            fontSize = 50;
        }
        
        SKEmitterNode *background = [SKEmitterNode ball_emitterNamed:@"BlazeParticle"];
        background.particlePositionRange = CGVectorMake(self.size.width*2, self.size.height*2);
        [background advanceSimulationTime:100];
        [self addChild:background];
        
        SKLabelNode *instructionsHeaderLabel = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        instructionsHeaderLabel.text = @"Instructions";
        instructionsHeaderLabel.fontSize = fontSize;
        instructionsHeaderLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.85);
        instructionsHeaderLabel.fontColor = [SKColor whiteColor];
        [self addChild:instructionsHeaderLabel];
        
        SKLabelNode *instructionsLabel1 = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        instructionsLabel1.text = @"Dodge the comets to stay alive.";
        instructionsLabel1.fontSize = fontSize * 0.5;
        instructionsLabel1.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.62);
        instructionsLabel1.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel1];
        
        SKLabelNode *instructionsLabel2 = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        instructionsLabel2.text = @"Drag your finger to move.";
        instructionsLabel2.fontSize = fontSize * 0.5;
        instructionsLabel2.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.52);
        instructionsLabel2.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel2];
        
        SKLabelNode *instructionsLabel3 = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        instructionsLabel3.text = @"Survive as long as possible.";
        instructionsLabel3.fontSize = fontSize * 0.5;
        instructionsLabel3.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.42);
        instructionsLabel3.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel3];
        
        SKLabelNode *instructionsLabel4 = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        instructionsLabel4.text = @"Achieve a high score.";
        instructionsLabel4.fontSize = fontSize * 0.5;
        instructionsLabel4.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.32);
        instructionsLabel4.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel4];
        
        SKLabelNode *backButton = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        backButton.text = @"Back";
        backButton.fontSize = fontSize * 0.8;
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

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

-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKLabelNode *instructionsHeaderLabel = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsHeaderLabel.text = @"Instructions";
        instructionsHeaderLabel.fontSize = 40;
        instructionsHeaderLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.9);
        instructionsHeaderLabel.fontColor = [SKColor whiteColor];
        [self addChild:instructionsHeaderLabel];
        
        //TODO: Separate instuctions into lines.
        SKLabelNode *instructionsLabel = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsLabel.text = @"Dodge the comets to stay alive.\nDrag your finger to move.\nAchieve a high score!\nHow long can you survive?";
        instructionsLabel.fontSize = 25;
        instructionsLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.7);
        instructionsLabel.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel];
        
        SKLabelNode *backButton = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        backButton.text = @"Back";
        backButton.fontSize = 25;
        backButton.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.3);
        backButton.fontColor = [SKColor whiteColor];
        [self addChild:backButton];
    }
    return self;
}

-(void)backToMenu
{
    MenuScene *menuScene = [[MenuScene alloc] initWithSize:self.size];
    [self.view presentScene:menuScene transition:[SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.5]];
}

@end

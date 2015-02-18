//
//  MenuScene.m
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-10.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"
#import "InstructionsScene.h"
#import "AppDelegate.h"

@implementation MenuScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        if (![[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]) {
            NSLog(@"init hs to 0");
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"highScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        self.highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"];
        
        SKEmitterNode *background = [SKEmitterNode ball_emitterNamed:@"BlazeParticle"];
        background.particlePositionRange = CGVectorMake(self.size.width*2, self.size.height*2);
        [background advanceSimulationTime:100];
        [self addChild:background];
        
        SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        highScoreLabel.text = [NSString stringWithFormat:@"High Score: %d", (int)self.highScore];
        highScoreLabel.fontSize = 20;
        highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.03);
        highScoreLabel.fontColor = [SKColor whiteColor];
        [self addChild:highScoreLabel];
        
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        title.text = @"Space Blaze";
        title.fontSize = 50;
        title.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.6);
        title.fontColor = [SKColor whiteColor];
        [self addChild:title];
        
        SKLabelNode *playButton = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        playButton.text = @"Play";
        playButton.fontSize = 30;
        playButton.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.3);
        playButton.fontColor = [SKColor whiteColor];
        playButton.name = @"playButton";
        [self addChild:playButton];
        
        SKLabelNode *instructionsButton = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext"];
        instructionsButton.text = @"Instructions";
        instructionsButton.fontSize = 30;
        instructionsButton.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.2);
        instructionsButton.fontColor = [SKColor whiteColor];
        instructionsButton.name = @"instructionsButton";
        [self addChild:instructionsButton];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    SKNode *touchNode = [self nodeAtPoint:touchLocation];
    
    if ([touchNode.name isEqualToString:@"playButton"]) {
        [self startGame];
    } else if ([touchNode.name isEqualToString:@"instructionsButton"]) {
        [self viewInstructions];
    }
}

- (void)startGame
{
    GameScene *newGame = [[GameScene alloc] initWithSize:self.size];
    [self.view presentScene:newGame transition:[SKTransition moveInWithDirection:SKTransitionDirectionDown duration:0.5]];
}

- (void)viewInstructions
{
    InstructionsScene *instructionsScene = [[InstructionsScene alloc] initWithSize:self.size];
    [self.view presentScene:instructionsScene transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
}

@end

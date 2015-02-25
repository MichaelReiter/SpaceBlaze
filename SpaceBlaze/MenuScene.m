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

        int fontSize;
        if (self.frame.size.width < 330) {          //iPhone 4S, 5, 5S
            fontSize = 38;
        } else if (self.frame.size.width < 380) {   //iPhone 6
            fontSize = 45;
        } else if (self.frame.size.width < 420) {   //iPhone 6 Plus
            fontSize = 50;
        } else {                                    //iPad
            fontSize = 65;
        }
        
        if (![[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]) {
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"highScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        self.highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"];

        SKEmitterNode *background = [SKEmitterNode ball_emitterNamed:@"BlazeParticle"];
        background.particlePositionRange = CGVectorMake(self.size.width * 2, self.size.height * 2);
        [background advanceSimulationTime:10];
        [self addChild:background];
         
        SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        highScoreLabel.text = [NSString stringWithFormat:@"High Score %d", (int)self.highScore];
        highScoreLabel.fontSize = fontSize/2;
        highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.03);
        highScoreLabel.fontColor = [SKColor whiteColor];
        [self addChild:highScoreLabel];
        
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        title.text = @"Space Blaze";
        title.fontSize = fontSize;
        title.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.6);
        title.fontColor = [SKColor whiteColor];
        [self addChild:title];
        
        SKLabelNode *playButton = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        playButton.text = @"Play";
        playButton.fontSize = fontSize * 0.65;
        playButton.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.31);
        playButton.fontColor = [SKColor whiteColor];
        playButton.name = @"playButton";
        [self addChild:playButton];
        
        SKLabelNode *instructionsButton = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        instructionsButton.text = @"Instructions";
        instructionsButton.fontSize = fontSize * 0.65;
        instructionsButton.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.19);
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
    [self runAction:[SKAction playSoundFileNamed:@"whoosh.mp3" waitForCompletion:NO]];
    [self.view presentScene:newGame transition:[SKTransition moveInWithDirection:SKTransitionDirectionDown duration:0.5]];
}

- (void)viewInstructions
{
    InstructionsScene *instructionsScene = [[InstructionsScene alloc] initWithSize:self.size];
    //Play instructions sound
    [self runAction:[SKAction playSoundFileNamed:@"whoosh.mp3" waitForCompletion:NO]];
    [self.view presentScene:instructionsScene transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
}

@end

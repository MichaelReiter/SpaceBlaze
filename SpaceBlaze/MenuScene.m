//
//  MenuScene.m
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-10.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"

@implementation MenuScene

-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        /*
        SKEmitterNode *background = [SKEmitterNode ball_emitterNamed:@"Background"];
        background.particlePositionRange = CGVectorMake(self.size.width*2, self.size.height*2);
        [background advanceSimulationTime:10];
        
        [self addChild:background];
        */
         
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Neue"];
        
        title.text = @"Space Blaze";
        title.fontSize = 50;
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        title.fontColor = [SKColor whiteColor];
        
        [self addChild:title];
        
        SKLabelNode *tapToPlay = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Neue"];
        
        tapToPlay.text = @"Tap to play";
        tapToPlay.fontSize = 30;
        tapToPlay.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 80);
        tapToPlay.fontColor = [SKColor whiteColor];
        
        [self addChild:tapToPlay];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    GameScene *newGame = [[GameScene alloc] initWithSize:self.size];
    [self.view presentScene:newGame transition:[SKTransition crossFadeWithDuration:0.5]];
}

@end

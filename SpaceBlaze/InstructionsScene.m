//
//  InstructionsScene.m
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-10.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import "InstructionsScene.h"

@implementation InstructionsScene

-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKLabelNode *instructionsLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Neue"];
        instructionsLabel.text = @"Instructions";
        instructionsLabel.fontSize = 30;
        instructionsLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.9);
        instructionsLabel.fontColor = [SKColor whiteColor];
        [self addChild:instructionsLabel];
    }
    return self;
}

@end

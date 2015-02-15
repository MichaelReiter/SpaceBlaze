//
//  MenuScene.h
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-10.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MenuScene : SKScene

@property NSInteger highScore;

- (void)startGame;

- (void)viewInstructions;

@end

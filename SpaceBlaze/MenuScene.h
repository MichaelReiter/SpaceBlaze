//
//  MenuScene.h
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-10.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MenuScene : SKScene

@property NSInteger highScore;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (void)startGame;

- (void)viewInstructions;

@end

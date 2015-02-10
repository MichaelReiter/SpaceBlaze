//
//  GameScene.h
//  SpaceBlaze
//

//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property (strong, nonatomic) SKNode *player;

@end

@interface SKEmitterNode (fromFile)

+(instancetype)ball_emitterNamed:(NSString*)name;

@end

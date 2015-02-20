//
//  GameScene.h
//  SpaceBlaze
//

//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property (strong, nonatomic) SKNode *player;

- (void)dieFrom:(SKNode*)killingEnemy;

- (void)saveHighScoreWithScore:(NSInteger)score;

- (void)updateScore;

- (void)spawnEnemy;

- (void)cleanUpChildrenAndRemove:(SKNode*)node;

@end

@interface SKEmitterNode (fromFile)

+ (instancetype)ball_emitterNamed:(NSString*)name;

@end

//
//  GameScene.m
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-09.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import "GameScene.h"
#import "CGVector+TC.h"

enum {
    CollisionPlayer = 1<<1,
    CollisionEnemy = 1<<2
};

@implementation GameScene

{
    SKNode *_player;
    NSMutableArray *_enemies;
}

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        _enemies = [NSMutableArray new];
        
        _player = [SKNode node];
        SKShapeNode *circle = [SKShapeNode node];
        circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-10, -10, 20, 20)].CGPath;
        circle.fillColor = [UIColor redColor];
        circle.strokeColor = [UIColor redColor];
        circle.glowWidth = 5;
        
        SKEmitterNode *trail = [SKEmitterNode ball_emitterNamed:@"BlazeParticle"];
        trail.position = CGPointMake(CGRectGetMidX(circle.frame), CGRectGetMidY(circle.frame));
        trail.targetNode = self;
        [_player addChild:trail];
        
        _player.position = CGPointMake(size.width/2, size.height/2);
        
        [self addChild:_player];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self performSelector:@selector(spawnEnemy) withObject:nil afterDelay:1.0];
}

-(void)spawnEnemy
{
    SKNode *enemy = [SKNode node];
    
    SKEmitterNode *enemyTrail = [SKEmitterNode ball_emitterNamed:@"BlazeParticle"];
    enemyTrail.targetNode = self;
    enemyTrail.particleScale /= 2;
    enemyTrail.position = CGPointMake(10, 10);
    
    enemyTrail.particleColorSequence = [[SKKeyframeSequence alloc]
        initWithKeyframeValues:@[
        [SKColor blueColor],
        [SKColor colorWithHue:0.5 saturation:0.5 brightness:1 alpha:1],
        [SKColor blueColor]]
        times:@[@0, @0.05, @0.2]];
    
    [enemy addChild:enemyTrail];
    
    //enemy.physicsBody.categoryBitMask = CollisionEnemy;
    enemy.physicsBody.allowsRotation = NO;
    enemy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:6];
    enemy.position = CGPointMake(50, 50);
    
    [_enemies addObject:enemy];
    [self addChild:enemy];
    
    [self runAction:[SKAction sequence:@[
        [SKAction waitForDuration:5],
        [SKAction performSelector:@selector(spawnEnemy) onTarget:self]
        ]]];
}

-(void)update:(NSTimeInterval)currentTime
{
    CGPoint playerPosition = _player.position;
    
    for (SKNode *enemyNode in _enemies) {
        CGPoint enemyPosition = enemyNode.position;
        
        CGVector diff = TCVectorMinus(playerPosition, enemyPosition);
        CGVector normalized = TCVectorUnit(diff);
        CGVector force = TCVectorMultiply(normalized, 4);
        
        [enemyNode.physicsBody applyForce:force];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_player runAction:[SKAction moveTo:[[touches anyObject] locationInNode:self] duration:0.1]];
}

@end

@implementation SKEmitterNode (fromFile)

+(instancetype)ball_emitterNamed:(NSString*)name
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:name ofType:@"sks"]];
}

@end

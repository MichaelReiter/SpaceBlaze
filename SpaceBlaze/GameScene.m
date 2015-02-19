//
//  GameScene.m
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-09.
//

#import "GameScene.h"
#import "CGVector+TC.h"
#import "MenuScene.h"

enum {
    CollisionPlayer = 1 << 1,
    CollisionEnemy = 1 << 2
};

@interface GameScene () <SKPhysicsContactDelegate>
@end

@implementation GameScene

{
    SKNode *_player;
    NSMutableArray *_enemies;
    BOOL _dead;
    SKLabelNode *_scoreLabel;
    
}

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
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
        
        _player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10];
        _player.physicsBody.mass = 100000;
        _player.physicsBody.categoryBitMask = CollisionPlayer;
        _player.physicsBody.contactTestBitMask = CollisionEnemy;
        [_player addChild:trail];
        _player.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:_player];
        
        [self updateScore];
        
        SKEmitterNode *background = [SKEmitterNode ball_emitterNamed:@"star"];
        background.particlePositionRange = CGVectorMake(self.size.width*2, self.size.height*2);
        [background advanceSimulationTime:100];
        [self addChild:background];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    [self performSelector:@selector(spawnEnemy) withObject:nil afterDelay:1];
}

- (void)spawnEnemy
{
    if (!_dead) {
        SKNode *enemy = [SKNode node];
        
        SKEmitterNode *enemyTrail = [SKEmitterNode ball_emitterNamed:@"enemyParticle"];
        enemyTrail.targetNode = self;
        enemyTrail.position = CGPointMake(10, 10);
        
        [enemy addChild:enemyTrail];
        enemy.physicsBody.categoryBitMask = CollisionEnemy;
        enemy.physicsBody.allowsRotation = NO;
        enemy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:6];
        enemy.position = CGPointMake(arc4random_uniform(self.frame.size.width), arc4random_uniform(self.frame.size.height));
        
        [_enemies addObject:enemy];
        [self addChild:enemy];
        [self updateScore];

        [self runAction:[SKAction sequence:@[
            [SKAction waitForDuration:5],
            [SKAction performSelector:@selector(spawnEnemy) onTarget:self]
            ]]];
    }
}

- (void)updateScore
{
    if (!_scoreLabel) {
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"GALACTICVANGUARDIANNCV"];
        _scoreLabel.fontSize = 25;
        _scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.9);
        _scoreLabel.fontColor = [SKColor whiteColor];
        _scoreLabel.text = @"0";
        [self addChild:_scoreLabel];
    }
    _scoreLabel.text = [NSString stringWithFormat:@"%d", (int)_enemies.count];
}

- (void)update:(NSTimeInterval)currentTime
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

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    if (_dead) {
        return;
    }
    
    [self dieFrom:contact.bodyB.node];
    contact.bodyB.node.physicsBody = nil;
}

- (void)dieFrom:(SKNode*)killingEnemy
{
    _dead = YES;
    
    SKEmitterNode *explosion = [SKEmitterNode ball_emitterNamed:@"Explosion"];
    explosion.position = _player.position;
    [self addChild:explosion];
    
    [explosion runAction:[SKAction sequence:@[
        [SKAction waitForDuration:0.2],
        [SKAction runBlock:^{
            [killingEnemy removeFromParent];
            [_player removeFromParent];
        }],
        [SKAction waitForDuration:0.2],
        [SKAction runBlock:^{
            explosion.particleBirthRate = 0;
        }],
        [SKAction waitForDuration:1.2],
        
        [SKAction runBlock:^{
        [self saveHighScoreWithScore:(int)_enemies.count];
        MenuScene *menu = [[MenuScene alloc] initWithSize:self.size];
        [self.view presentScene:menu transition:[SKTransition moveInWithDirection:SKTransitionDirectionUp duration:0.5]];
        }]
    ]]];
}

- (void)saveHighScoreWithScore:(NSInteger)score
{
    if (score > [[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"highScore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
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

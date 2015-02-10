//
//  GameScene.m
//  SpaceBlaze
//
//  Created by Michael Reiter on 2015-02-09.
//  Copyright (c) 2015 Michael Reiter. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        
        self.player = [SKNode node];
        SKShapeNode *circle = [SKShapeNode node];
        circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-10, -10, 20, 20)].CGPath;
        circle.fillColor = [UIColor redColor];
        circle.strokeColor = [UIColor redColor];
        circle.glowWidth = 5;
        
        SKEmitterNode *trail = [SKEmitterNode ball_emitterNamed:@"BlazeParticle"];
        trail.position = CGPointMake(CGRectGetMidX(circle.frame), CGRectGetMidY(circle.frame));
        trail.targetNode = self;
        [self.player addChild:trail];
        
        self.player.position = CGPointMake(size.width/2, size.height/2);
        
        [self addChild:self.player];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.player runAction:[SKAction moveTo:[[touches anyObject] locationInNode:self] duration:0.1]];
}

@end

@implementation SKEmitterNode (fromFile)

+(instancetype)ball_emitterNamed:(NSString*)name
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:name ofType:@"sks"]];
}

@end

//
//  GameScene.m
//  SKSCN Crossover
//
//  Created by Edwin on 02-12-14.
//  Copyright (c) 2014 Veger. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
  CGPoint center = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
	NSLog(@"didmove center: %@", NSStringFromCGPoint(center));
	
	[self createLabels];

  self.shipScene = [TDScene shipScene];
	
	CGSize s = CGSizeMake(600,450);
  self.tdNode = [SK3DNode nodeWithViewportSize:s];
  self.tdNode.name = @"3d node";
  self.tdNode.position = center;
  self.tdNode.scnScene = self.shipScene;
  [self.tdNode setPointOfView:self.shipScene.camera];
	self.tdNode.alpha = 0.25f;

	{
#warning This code is very important in iOS 8.1. Without these lines (which presumably initiate the SCNRenderer, the app crashes immediately.
		id s1 = [self.tdNode valueForKey:@"_scnRenderer"];
		NSLog(@"%@", s1);
	}
	
	[self addChild:self.tdNode];
	
	// a sprite which underlaps the SK3DNode.
	SKSpriteNode *sprite = [[SKSpriteNode alloc] initWithColor:[SKColor colorWithRed:1 green:0.5 blue:0 alpha:0.25f] size:s];
	sprite.position = center;
	sprite.zPosition = -100;
	[self addChild:sprite];
}

- (void) createLabels {
	CGFloat fontSize = 24;
	CGFloat y = 640;
	
	self.toggleRotation = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
	self.toggleRotation.text = @"Toggle rotation";
	self.toggleRotation.fontSize = fontSize;
	self.toggleRotation.position = CGPointMake(128, y);
	[self addChild:self.toggleRotation];
	
	self.toggleThrust = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
	self.toggleThrust.text = @"Toggle thrust";
	self.toggleThrust.fontSize = fontSize;
	self.toggleThrust.position = CGPointMake(384, y);
	[self addChild:self.toggleThrust];

	self.toggleToonShader = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
	self.toggleToonShader.text = @"Toggle toon";
	self.toggleToonShader.fontSize = fontSize;
	self.toggleToonShader.position = CGPointMake(640, y);
	[self addChild:self.toggleToonShader];

	self.toggleGeometryShader = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
	self.toggleGeometryShader.text = @"Toggle deformation";
	self.toggleGeometryShader.fontSize = fontSize;
	self.toggleGeometryShader.position = CGPointMake(880, y);
	[self addChild:self.toggleGeometryShader];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint position = [touch locationInNode:self];
	
	SKLabelNode *selectedLabel = nil;
	
	if ([self.toggleRotation containsPoint:position]) {
		[self.shipScene toggleRotation];
		selectedLabel = self.toggleRotation;
	}

	if ([self.toggleThrust containsPoint:position]) {
		[self.shipScene toggleThrust];
		selectedLabel = self.toggleThrust;
	}
	
	if ([self.toggleToonShader containsPoint:position]) {
		[self.shipScene toggleToonShader];
		selectedLabel = self.toggleToonShader;
	}
	
	if ([self.toggleGeometryShader containsPoint:position]) {
		[self.shipScene toggleGeometryShader];
		selectedLabel = self.toggleGeometryShader;
	}
	
	if (selectedLabel) {
		selectedLabel.fontColor = [UIColor greenColor];
		SKAction *colorWhite = [SKAction customActionWithDuration:.2f actionBlock:^(SKNode *node, CGFloat elapsedTime) {
			CGFloat progress = elapsedTime / .2f;
			
			((SKLabelNode*)node).fontColor = [UIColor colorWithRed:progress green:1 blue:progress alpha:1];
		}];
		[selectedLabel runAction:colorWhite];
	}
	
  return;
}

@end

//
//  GameViewController.m
//  SKSCN Crossover
//
//  Created by Edwin on 02-12-14.
//  Copyright (c) 2014 Veger. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@import SpriteKit;

@implementation GameViewController

- (void) loadView {
	NSLog(@"uiscreen size %@",NSStringFromCGRect([[UIScreen mainScreen] bounds]));
	
	SKView *sk = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	sk.backgroundColor = [UIColor purpleColor];
	
	sk.showsFPS = YES;
	sk.showsNodeCount = YES;
	sk.ignoresSiblingOrder = YES;
	sk.showsDrawCount = YES;
	
	self.view = (UIView *)sk;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Create and configure the scene.
	GameScene *scene = [[GameScene alloc] initWithSize:self.skview.frame.size];
	NSLog(@"skview fame size %@",NSStringFromCGRect(self.skview.frame));
//	scene.scaleMode = SKSceneScaleModeAspectFill;

	// Present the scene.
	[self.skview presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (SKView *) skview {
	return (SKView *)self.view;
}

@end

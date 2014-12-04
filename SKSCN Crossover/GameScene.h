//
//  GameScene.h
//  SKSCN Crossover
//

//  Copyright (c) 2014 Veger. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TDScene.h"

/// The main SKScene which contains the SK3DNode and some labels.
@interface GameScene : SKScene

@property (strong,nonatomic) SK3DNode *tdNode;

@property (strong,nonatomic) TDScene *shipScene;

// BUTTONS

@property (strong,nonatomic) SKLabelNode *toggleRotation;
@property (strong,nonatomic) SKLabelNode *toggleThrust;
@property (strong,nonatomic) SKLabelNode *toggleToonShader;
@property (strong,nonatomic) SKLabelNode *toggleGeometryShader;

@end

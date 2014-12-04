//
//  TDScene.m
//  SKSCN Crossover
//
//  Created by Edwin on 02-12-14.
//  Copyright (c) 2014 Veger. All rights reserved.
//

#import "TDScene.h"

@implementation TDScene

+ (TDScene *)shipScene
{
  TDScene *scene = [TDScene sceneNamed:@"art.scnassets/ship.dae"];
	
	// remember the ship
  scene.ship = [scene.rootNode childNodeWithName:@"ship" recursively:YES];
	
	// create and add a camera to the scene
	scene.camera = [SCNNode node];
	scene.camera.camera = [SCNCamera camera];
	scene.camera.position = SCNVector3Make(0, 0, 15);
	scene.camera.camera.xFov = 40; // so we can see more of our center of frame: the harrier
	scene.camera.camera.yFov = 40;
	[scene.rootNode addChildNode:scene.camera];
	
	 // create and add a light to the scene
	 SCNNode *lightNode = [SCNNode node];
	 lightNode.light = [SCNLight light];
	 lightNode.light.type = SCNLightTypeDirectional;
	 lightNode.position = SCNVector3Make(0, 10, 10);
	 lightNode.rotation = SCNVector4Make(1, 1, 0, -M_PI_4);
	 lightNode.light.color = [UIColor colorWithRed:0.7f green:0.7f blue:7 alpha:1];
	 [scene.rootNode addChildNode:lightNode];
	 
	 // create and add an ambient light to the scene
	 SCNNode *ambientLightNode = [SCNNode node];
	 ambientLightNode.light = [SCNLight light];
	 ambientLightNode.light.type = SCNLightTypeAmbient;
	 ambientLightNode.light.color = [UIColor darkGrayColor];
	 [scene.rootNode addChildNode:ambientLightNode];
	
	/* EMITTERS */
#warning These emitters appear to have a big impact on initial loading time. Comment these lines and see the difference.
	{
		scene.thrust1 = [scene.rootNode childNodeWithName:@"emitter" recursively:YES];
		SCNParticleSystem *ps = [SCNParticleSystem particleSystemNamed:@"Smoke" inDirectory:nil];
		[scene.thrust1 addParticleSystem:ps];
		
		scene.thrust2 = [scene.thrust1 clone];
		{
			SCNVector3 v = scene.thrust2.position;
			v.x *= -1;
			scene.thrust2.position = v;
		}
		SCNParticleSystem *ps2 = [SCNParticleSystem particleSystemNamed:@"Smoke" inDirectory:nil];
		[scene.thrust2 addParticleSystem:ps2];
		[scene.thrust1.parentNode addChildNode:scene.thrust2];
		
		[scene.thrust1 removeFromParentNode];
		[scene.thrust2 removeFromParentNode];
	} // */
	
	return scene;
}

/// CONTROLS

- (void)toggleRotation {
	// animate the 3d object
	if ([self.ship actionForKey:@"rotation"]) {
		[self.ship removeAllActions];
	} else {
		[self.ship runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:5]] forKey:@"rotation"];
	}
}

- (void)toggleThrust {
	if (self.thrust1.parentNode) {
		[self.thrust1 removeFromParentNode];
		[self.thrust2 removeFromParentNode];
	} else {
		SCNNode *mesh = [self.ship.childNodes firstObject];
		
		[mesh addChildNode:self.thrust1];
		[mesh addChildNode:self.thrust2];
	}
}

- (void)toggleToonShader {
	// retrieve the ship node
	SCNNode *mesh = [self.ship.childNodes firstObject];
	SCNGeometry *g = mesh.geometry;
	
	NSMutableDictionary *shaderModifiers = [g.shaderModifiers mutableCopy];
	
	if (!shaderModifiers) shaderModifiers = [NSMutableDictionary new];
	
	if (![shaderModifiers objectForKey:SCNShaderModifierEntryPointLightingModel]) {
		[shaderModifiers setObject:self.lightCelShadingModifier forKey:SCNShaderModifierEntryPointLightingModel];
		[g setValue:@1.0 forKey:@"lightIntensity"];
	} else {
		[shaderModifiers removeObjectForKey:SCNShaderModifierEntryPointLightingModel];
	}
	
	g.shaderModifiers = [shaderModifiers copy];
}

- (void)toggleGeometryShader {
	// retrieve the ship node
	SCNNode *mesh = [self.ship.childNodes firstObject];
	SCNGeometry *g = mesh.geometry;
	
	NSMutableDictionary *shaderModifiers = [g.shaderModifiers mutableCopy];
	
	CGFloat tgtFactor;
	
	if (!shaderModifiers) shaderModifiers = [NSMutableDictionary new];
	
	if (![shaderModifiers objectForKey:SCNShaderModifierEntryPointGeometry]) {
		[shaderModifiers setObject:self.geomModifier forKey:SCNShaderModifierEntryPointGeometry];
		tgtFactor = .3;
	} else {
		[shaderModifiers removeObjectForKey:SCNShaderModifierEntryPointGeometry];
		tgtFactor = 0.0;
	}
	
	[SCNTransaction begin];
	[SCNTransaction setAnimationDuration:2.0];
	g.shaderModifiers = [shaderModifiers copy];
	[g setValue:[NSNumber numberWithFloat:tgtFactor] forKey:@"twistFactor"];
	[SCNTransaction commit];
}

/// SHADER MODIFIERS

- (NSString *)fragModifier {
	if (_fragModifier) {
		_fragModifier = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sm_frag" ofType:@"shader"] encoding:NSUTF8StringEncoding error:nil];
	}
	
	return _fragModifier;
}

- (NSString *)lightCelShadingModifier {
	if (!_lightCelShadingModifier) {
		_lightCelShadingModifier = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sm_light_cel_shading" ofType:@"shader"] encoding:NSUTF8StringEncoding error:nil];
	}
	
	return _lightCelShadingModifier;
}

- (NSString *)geomModifier {
	if (!_geomModifier) {
		_geomModifier = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sm_geom" ofType:@"shader"] encoding:NSUTF8StringEncoding error:nil];
	}
	
	return _geomModifier;
}

@end

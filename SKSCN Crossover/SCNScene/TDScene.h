//
//  TDScene.h
//  SKSCN Crossover
//
//  Created by Edwin on 02-12-14.
//  Copyright (c) 2014 Veger. All rights reserved.
//

@import SceneKit;

/// The scene which will be rendered into a SK3DNode. Loads ship.dae.
@interface TDScene : SCNScene

+ (TDScene *)shipScene;

/// Toggles ship rotation.
- (void)toggleRotation;
/// Adds/removes the ParticleSystems to the scene. Really messes up how the main model is rendered for some reason.
- (void)toggleThrust;
/// A custom shader which divides light impact in to binary categories for a toony effect.
- (void)toggleToonShader;
/// A custom twist effect. Copied from http://www.objc.io/issue-18/scenekit.html
- (void)toggleGeometryShader;

@property (strong, nonatomic) SCNNode *camera;
@property (strong, nonatomic) SCNNode *ship;

@property (strong, nonatomic) SCNNode *thrust1;
@property (strong, nonatomic) SCNNode *thrust2;

#pragma mark Shader modifiers

/// Fiddle around to see what this does... Be sure to use SCNShaderModifierEntryPointFragment, though!
@property (strong, nonatomic) NSString *fragModifier;
/// A string with the contents of "sm_light_cel_shading.shader". A custom OpenGL shading modifier for a toon effect.
@property (strong, nonatomic) NSString *lightCelShadingModifier;
@property (strong, nonatomic) NSString *geomModifier;

@end

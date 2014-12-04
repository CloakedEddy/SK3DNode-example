SK3DNode-example
================

[SK3DNode](https://developer.apple.com/Library/ios/documentation/SpriteKit/Reference/SK3DNode/index.html) is a subclass of SKNode and can display a SceneKit scene ([SCNScene](https://developer.apple.com/library/ios/DOCUMENTATION/SceneKit/Reference/SCNScene_Class/index.html)), but within the context of a Sprite Kit scene ([SKScene](https://developer.apple.com/library/IOs/documentation/SpriteKit/Reference/SKScene_Ref/index.html)). This is useful if you wish to display a 3D model in your 2D Sprite Kit application.

This sample project displays usage of the SK3DNode provided by the Sprite Kit framework in iOS since iOS 8. Since I could not find any working sample code online, I had to try it on my own. Learning how to get this to work was particularly cumbersome, and therefore I decided to create a brief example which should point people in the right direction.
> Usage of SK3DNode is compliant with the spirit of both the Sprite Kit and SceneKit frameworks, but there are two lines in particular which shouldn't be necessary. But, without them, the app crashes inside an `SCNRenderer` instance. After creating the `SK3DNode`, initiate the `SCNRenderer` like so:
> 
> 	  id s1 = [self.tdNode valueForKey:@"_scnRenderer"];
>     NSLog(@"%@", s1);

As a bonus, there are a couple of custom shaders for you to experiment with :)

Please feel free to improve my code where you feel it would better serve the educational purpose.

__Disclaimer__

I have worked off the SceneKit template project provided by Xcode.
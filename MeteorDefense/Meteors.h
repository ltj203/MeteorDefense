//
//  Meteors.h
//  MeteorDefense
//
//  Created by Lisa Jenkins on 2/20/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Meteors : UIView

@property float deltaX;
@property float deltaY;

-(id) initMeteorAtX: (CGFloat)x AndY: (CGFloat)y  withSize: (CGFloat) meteorSize;

@end

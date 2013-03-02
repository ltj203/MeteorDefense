//
//  Rockets.h
//  MeteorDefense
//
//  Created by Lisa Jenkins on 2/20/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Rockets : UIView
@property CGFloat touchX, touchY, endX, endY, yIntercept, slope;

-(id) initRocketWithSize: (CGFloat) rocketSize;

@end

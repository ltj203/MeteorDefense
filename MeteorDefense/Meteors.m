//
//  Meteors.m
//  MeteorDefense
//
//  Created by Lisa Jenkins on 2/20/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import "Meteors.h"

@implementation Meteors
@synthesize deltaX, deltaY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initMeteorAtX: (CGFloat)x AndY: (CGFloat)y  withSize: (CGFloat) meteorSize{
    CGRect frame = CGRectMake(x,y,meteorSize,meteorSize);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        deltaX = 0.2;
        deltaY = 0.5;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

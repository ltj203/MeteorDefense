//
//  Rockets.m
//  MeteorDefense
//
//  Created by Lisa Jenkins on 2/20/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import "Rockets.h"

@implementation Rockets
@synthesize touchX, touchY, endX, endY, yIntercept, slope;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initRocketWithSize: (CGFloat) rocketSize {
    
    CGRect frame = CGRectMake(([UIScreen mainScreen].applicationFrame.size.width - rocketSize)/2, [UIScreen mainScreen].applicationFrame.size.height - rocketSize - 75, rocketSize, rocketSize);
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor redColor];
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

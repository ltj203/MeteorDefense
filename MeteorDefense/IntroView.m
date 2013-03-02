//
//  IntroView.m
//  MeteorDefense
//
//  Created by Lisa Jenkins on 2/25/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import "IntroView.h"

@implementation IntroView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

static void drawStars(void *p, CGContextRef c){
    CGFloat scale = *(CGFloat *)p;
    CGContextSetLineWidth(c, 1/scale);
    CGContextBeginPath(c);
    
    CGContextAddEllipseInRect(c, CGRectMake(0, 0, 0.1, 0.1));
    CGContextSetRGBFillColor(c, 1, 1, 1, 1);
    CGContextFillPath(c);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGSize size = self.bounds.size;
    
    CGAffineTransform translate = CGAffineTransformMakeTranslation(size.width/2, size.height/2);
    
    CGFloat scale = size.width/(4*M_PI);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGAffineTransform patternScale = CGAffineTransformMakeScale(scale, scale);
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
	CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(baseSpace);
	CGContextSetFillColorSpace(c, patternSpace);
	CGColorSpaceRelease(patternSpace);
	CGColorSpaceRelease(baseSpace);
    
    
    static const CGPatternCallbacks callbacks = {0, drawStars, NULL};
    
    CGAffineTransform patternTransform = CGAffineTransformConcat(patternScale, translate);
    
    CGPatternRef pattern = CGPatternCreate(&scale, CGRectMake(0, 0, 0.5, 0.5), patternTransform, 2, 2, kCGPatternTilingConstantSpacing, false, &callbacks);
    
    static const CGFloat color[] = {0,0,1,1};
    CGContextSetFillPattern(c, pattern, color);
    CGPatternRelease(pattern);
    CGContextFillRect(c, self.bounds);
    
}


@end

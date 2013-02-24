//
//  MeteorDefenseViewController.m
//  MeteorDefense
//
//  Created by Lisa Jenkins on 2/20/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import "MeteorDefenseViewController.h"
#import "Meteors.h"
#import "Rockets.h"

NSMutableArray *meteorArray;
NSTimer *meteorTimer;

@interface MeteorDefenseViewController ()

@end

@implementation MeteorDefenseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    meteorArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<1000; i++) {
        NSUInteger randomX = arc4random()%240;
        
        Meteors *meteor = [[Meteors alloc] initMeteorAtX:randomX+i AndY:-10*i withSize:30];
        //meteor.deltaY = i*.8;
        meteor.deltaX = 0.2+i;
        [meteorArray addObject:meteor];
        [self.view addSubview:meteor];
    }
    
    meteorTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f/60.0f target:self selector:@selector(rainDown) userInfo:nil repeats:YES];
    
    
	
    
}

-(void) rainDown {
    for (int i=0; i<[meteorArray count]; i++) {
        Meteors *rock = [meteorArray objectAtIndex:i];
        rock.center = CGPointMake(rock.center.x, rock.center.y + rock.deltaY);
        Meteors *lastRock = [meteorArray lastObject];
        
        CGRect mainFrame = [UIScreen mainScreen].applicationFrame;
        
        if (lastRock.center.y>(mainFrame.origin.y + mainFrame.size.height)) {
            [self performSegueWithIdentifier:@"segueToStart" sender:self];
        }
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGRect mainFrame = [UIScreen mainScreen].applicationFrame;
    
    if (touches.count > 0) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        Rockets *newRocket = [[Rockets alloc] initRocketWithSize:30];
        [self.view addSubview:newRocket];
        [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
            CGFloat slope = (point.y - newRocket.frame.origin.y)/(point.x - newRocket.frame.origin.x);
            
            CGFloat yIntercept = point.y - slope*point.x;
            
            CGFloat endX = 500;
            if (point.x < mainFrame.size.width/2) {
                endX = -260;
            }
            if (point.x == mainFrame.size.width/2) {
                endX = mainFrame.size.width/2;
            }
            
            newRocket.center = CGPointMake(endX, slope*endX + yIntercept);
            
            for (int i=0; i<meteorArray.count; i++) {
                Meteors *meteor = [meteorArray objectAtIndex:i];
                
                if (CGRectIntersectsRect(meteor.frame, newRocket.frame)) {
                    [meteor setAlpha:0];
                    [newRocket removeFromSuperview];
                }
            }
            
        } completion: NULL
        ];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

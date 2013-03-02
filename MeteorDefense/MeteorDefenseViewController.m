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
#import "IntroView.h"

NSMutableArray *meteorArray;
NSMutableArray *movingMeteors;
NSMutableArray *rocketsArray;
NSTimer *meteorTimer;
UIImageView *ship;
NSUInteger meteorCount=0;
NSUInteger rocketCount=0;
NSUInteger hits = 0;
NSUInteger misses = 0;
UILabel *scoreLabel;
UIImageView *explosion;

@interface MeteorDefenseViewController ()

@end

@implementation MeteorDefenseViewController
@synthesize score;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IntroView *intro = [[IntroView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    self.view = intro;
    
    meteorArray = [[NSMutableArray alloc] init];
    rocketsArray = [[NSMutableArray alloc] init];
    movingMeteors = [[NSMutableArray alloc] init];
    
    for (int i=1; i<101; i++) {
        CGFloat randomX = arc4random()%200;
        
        UIImageView *newMeteor = [[UIImageView alloc] initWithFrame:CGRectMake(randomX, -100*i, 95, 95)];
        
        newMeteor.image = [UIImage imageNamed:@"meteor.png"];
        newMeteor.backgroundColor = [UIColor clearColor];
        
        [meteorArray addObject:newMeteor];
        [self.view addSubview:newMeteor];
    }
    
    ship = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height-100, 100, 100)];
    ship.image = [UIImage imageNamed:@"rocket.gif"];
    ship.backgroundColor = [UIColor clearColor];
    [intro addSubview:ship];
    
    NSString *string = @"M";
    UIFont *font = [UIFont fontWithName: @"MarkerFelt-Thin" size:20];
    CGSize s = [string sizeWithFont:font];
    CGRect labelFrame = CGRectMake(self.view.frame.origin.x + self.view.frame.size.width/2 + ship.frame.size.width/6, self.view.frame.origin.y + self.view.frame.size.height - s.height*2, s.width*40, s.height);
    scoreLabel = [[UILabel alloc] initWithFrame:labelFrame];
    scoreLabel.font = font;
    scoreLabel.text = [NSString stringWithFormat:@"Hits: %i Misses: %i", hits, misses];
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scoreLabel];
    
    meteorTimer = [NSTimer scheduledTimerWithTimeInterval:60.0f/60.0f target:self selector:@selector(sendMeteor) userInfo:nil repeats:YES];
    
}

-(void) sendMeteor {
    [movingMeteors addObject:[meteorArray objectAtIndex:meteorCount]];
    
    [NSTimer scheduledTimerWithTimeInterval:5.0f/60.0f target:self selector:@selector(moveMeteor) userInfo:nil repeats:YES];
    
    meteorCount++;
    
}

-(void) moveMeteor {
    CGFloat endX = arc4random()%500;
    [explosion removeFromSuperview];
    
    for (int i=0; i<movingMeteors.count-1; i++) {
        UIImageView *currentMeteor = [movingMeteors objectAtIndex:i];
    
        CGFloat deltaX = 0;
    
        if (currentMeteor.center.x <endX) {
            deltaX = 1;
        } else if (currentMeteor.center.x > endX){
            deltaX = -1;
        }
    
        CGFloat newX = currentMeteor.center.x;
        CGFloat newY = currentMeteor.center.y + 0.5;
    
        currentMeteor.center = CGPointMake(newX, newY);
        
    }
    
}



-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (touches.count > 0) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        CGFloat touchX = point.x;
        CGFloat touchY = point.y;
        
        Rockets *newRocket = [[Rockets alloc] initRocketWithSize:15];
        newRocket.touchX = touchX;
        newRocket.touchY = touchY;
        [rocketsArray addObject:newRocket];
        
        CGRect mainFrame = [UIScreen mainScreen].applicationFrame;
        
        newRocket.slope = (touchY - mainFrame.size.height - newRocket.frame.size.height - 75)/(touchX - (mainFrame.size.width - newRocket.frame.size.height)/2);
        
        newRocket.yIntercept = touchY - touchX*newRocket.slope;
        
        newRocket.endX = 500;
        
        if (touchX < mainFrame.size.width/2) {
            newRocket.endX = -260;
        }
        newRocket.endY = newRocket.slope*newRocket.endX + newRocket.yIntercept;
        
        if (touchX == mainFrame.size.width/2) {
            newRocket.endX = mainFrame.size.width/2;
            newRocket.endY = -150;
        }
        
        [NSTimer scheduledTimerWithTimeInterval:3.0f/60.0f target:self selector:@selector(moveRocket) userInfo:nil repeats:YES];
    }
    
}

-(void) moveRocket {
    
    for (int i=0; i<rocketsArray.count-1; i++) {
        Rockets *rocket = [rocketsArray objectAtIndex:i];
        [self.view addSubview: rocket];
        
        CGFloat deltaX = 0;
    
        if (rocket.center.x < rocket.endX) {
            deltaX = 1;
        } else if (rocket.center.x > rocket.endX){
            deltaX = -1;
        } else {
            deltaX = 0;
        }
    
        CGFloat newY = rocket.slope * (rocket.center.x + deltaX) + rocket.yIntercept;
        if (newY ==0) {
            newY = rocket.center.y -1;
        }
        
        for (int j=0; j<movingMeteors.count-1; j++) {
                UIImageView *meteor = [movingMeteors objectAtIndex:j];
                
                if (CGRectIntersectsRect(meteor.frame, rocket.frame)) {
                    CGRect blastFrame = CGRectMake(meteor.center.x, meteor.center.y, 100, 100);
                    explosion = [[UIImageView alloc] initWithFrame:blastFrame];
                    explosion.image = [UIImage imageNamed:@"explosion-hi.png"];
                    [self.view addSubview:explosion];
                    [meteor removeFromSuperview];
                    [rocket removeFromSuperview];
                    [rocketsArray removeObject:rocket];
                    [movingMeteors removeObject:meteor];
                    hits++;
                    score++;
                    scoreLabel.text = [NSString stringWithFormat:@"Hits: %i Misses: %i", hits, misses];
                    if (hits >= 20) {
                        [self performSegueWithIdentifier:@"segueToOver" sender:self];
                    }
                    break;
                }
            
                if (meteor.center.y > [UIScreen mainScreen].applicationFrame.size.height) {
                    [movingMeteors removeObject:meteor];
                    misses++;
                    scoreLabel.text = [NSString stringWithFormat:@"Hits: %i Misses: %i", hits, misses];
                    
                    if (misses >= 20) {
                        [self performSegueWithIdentifier:@"segueToOver" sender:self];
                    }
                    break;
                }
        }
    
        rocket.center = CGPointMake(rocket.center.x + deltaX, newY);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  IntroViewController.m
//  MeteorDefense
//
//  Created by Lisa Jenkins on 2/24/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import "IntroViewController.h"
#import "IntroView.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

UILabel *gameLabel;
NSTimer *meteorTimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IntroView *intro = [[IntroView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = intro;
    
    CGRect titleFrame = CGRectMake(self.view.frame.origin.x + 12, self.view.frame.origin.y + 25, self.view.frame.size.width, self.view.frame.size.height/3);
     gameLabel = [[UILabel alloc] initWithFrame:titleFrame];
     gameLabel.backgroundColor = [UIColor clearColor];
     gameLabel.textColor = [UIColor whiteColor];
     gameLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:40];
     gameLabel.text = @"METEOR BLASTER";
     
     [self.view addSubview: gameLabel];
    
    CGRect labelFrame = CGRectMake(self.view.frame.origin.x + self.view.frame.size.width/4, self.view.frame.origin.y + self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
     UILabel *tapToPlay = [[UILabel alloc] initWithFrame:labelFrame];
     tapToPlay.backgroundColor = [UIColor clearColor];
     tapToPlay.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:30];
     tapToPlay.text = @"Tap To Play";
     tapToPlay.textColor = [UIColor whiteColor];
     [self.view addSubview:tapToPlay];
    
    meteorTimer = [NSTimer scheduledTimerWithTimeInterval:60.0f/60.0f target:self selector:@selector(sendMeteor) userInfo:nil repeats:YES];
}

-(void) sendMeteor {
    
    CGFloat randomX = arc4random()%200;
  
    CGFloat screenHeight = [UIScreen mainScreen].applicationFrame.size.height;
    
    UIImageView *newMeteor = [[UIImageView alloc] initWithFrame:CGRectMake(randomX, -200, 100, 100)];
    
    CGFloat endX = arc4random()%500;
    
    newMeteor.image = [UIImage imageNamed:@"meteor.png"];
    newMeteor.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:newMeteor];
    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationCurveLinear animations:^{
        
        CGFloat slope = (screenHeight+200)/(endX - randomX);
        
        CGFloat yIntercept = screenHeight+200 - slope*endX;
      
        newMeteor.center = CGPointMake(endX, slope*endX + yIntercept);
        
    } completion:NULL];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [meteorTimer invalidate];
    
    [self performSegueWithIdentifier:@"segueToGame" sender:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

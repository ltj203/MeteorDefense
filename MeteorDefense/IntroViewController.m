//
//  IntroViewController.m
//  MeteorDefense
//
//  Created by Lisa Jenkins on 2/24/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIView *introView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
        introView.backgroundColor = [UIColor blackColor];
        self.view = introView;
        
        CGRect titleFrame = CGRectMake(self.view.frame.origin.x + 10, self.view.frame.origin.y + 25, self.view.frame.size.width*3/4, self.view.frame.size.height/3);
        UIView *title = [[UIView alloc] initWithFrame: titleFrame];
        title.backgroundColor = [UIColor orangeColor];
        
        UILabel *gameLabel = [[UILabel alloc] initWithFrame:titleFrame];
        gameLabel.backgroundColor = [UIColor clearColor];
        gameLabel.textColor = [UIColor whiteColor];
        gameLabel.font = [UIFont fontWithName:@"Helvetica" size:45];
        gameLabel.text = @"Meteor Shower";
        
        [title addSubview:gameLabel];
        [self.view addSubview:title];
        
        UILabel *tapToPlay = [[UILabel alloc] initWithFrame:titleFrame];
        tapToPlay.center = CGPointMake(tapToPlay.frame.origin.x, self.view.frame.size.height*2/3);
        tapToPlay.font = [UIFont fontWithName:@"Helvetica" size:30];
        tapToPlay.text = @"Tap To Play";
        tapToPlay.textColor = [UIColor whiteColor];
        [self.view addSubview:tapToPlay];
        
        
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    [self performSegueWithIdentifier:@"segueToGame" sender:self];
    
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    printf("Prepare for Segue");
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

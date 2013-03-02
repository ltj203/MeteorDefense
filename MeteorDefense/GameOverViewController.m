//
//  GameOverViewController.m
//  MeteorDefense
//
//  Created by Lisa Jenkins on 3/2/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import "GameOverViewController.h"
#import "IntroView.h"
#import <QuartzCore/QuartzCore.h>

@interface GameOverViewController ()

@end

@implementation GameOverViewController

@synthesize passedScore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    IntroView *intro = [[IntroView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = intro;
    
    UIFont *font = [UIFont fontWithName:@"MarkerFelt-Thin" size:25];
    CGFloat height = [@"A" sizeWithFont:font].height;
    CGRect labelframe = CGRectMake(self.view.frame.origin.x + 12, self.view.frame.origin.y + height, self.view.frame.size.width, self.view.frame.size.height/3);
    scoreLabel = [[UILabel alloc] initWithFrame:labelframe];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %i", passedScore];
    scoreLabel.font = font;
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.backgroundColor = [UIColor clearColor];
    
    CGRect textFieldFrame = CGRectMake(self.view.frame.origin.x + 12, self.view.frame.origin.y + height, self.view.frame.size.width, height);
    name = [[UITextField alloc] initWithFrame:textFieldFrame];
    name.borderStyle = UITextBorderStyleNone;
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor whiteColor];
    name.clearButtonMode = UITextFieldViewModeAlways;
    name.keyboardType = UIKeyboardTypeAlphabet;
    name.returnKeyType = UIReturnKeyDone;
    name.font = font;
    name.placeholder = @"<enter your name here>";
    name.autocorrectionType = UITextAutocorrectionTypeNo;
    name.delegate = self;
    
    nameLabel = [[UILabel alloc] initWithFrame: textFieldFrame];
    nameLabel.font = font;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:scoreLabel];
    [self.view addSubview:name];
    
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        textField.placeholder = @"<enter your name here>";
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        nameLabel.text = @"";
    } else {
        nameLabel.text = name.text;
        [self.view addSubview:nameLabel];
        [name removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

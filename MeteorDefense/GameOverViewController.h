//
//  GameOverViewController.h
//  MeteorDefense
//
//  Created by Lisa Jenkins on 3/2/13.
//  Copyright (c) 2013 nyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController <UITextFieldDelegate>{
    UITextField *name;
    UILabel *nameLabel;
    UILabel *scoreLabel;
}

@property (nonatomic) int passedScore;

@end

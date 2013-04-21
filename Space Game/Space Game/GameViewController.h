//
//  GameViewController.h
//  Space Game
//
//  Created by Daan Lemmen on 20-04-13.
//  Copyright (c) 2013 Daan Lemmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>
@interface GameViewController : UIViewController <UIAlertViewDelegate>
@property (nonatomic, strong) IBOutlet UIView *gameView;
@property (nonatomic, strong) IBOutlet UIView *rocketView;
@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) IBOutlet UIButton *rightButton;
@property (nonatomic, strong) IBOutlet UIImageView *leftButtonImg;
@property (nonatomic, strong) IBOutlet UIImageView *rightButtonImg;
@property (nonatomic, strong) IBOutlet UILabel *tijdLabel;
@end

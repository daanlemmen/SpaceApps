//
//  GameViewController.m
//  Space Game
//
//  Created by Daan Lemmen on 20-04-13.
//  Copyright (c) 2013 Daan Lemmen. All rights reserved.
//
float randomFloat(float Min, float Max){
    return ((arc4random()%RAND_MAX)/(RAND_MAX*1.0))*(Max-Min)+Min;
}
#import "GameViewController.h"
@interface GameViewController ()
@property (nonatomic, strong) NSTimer *timerLeft;
@property (nonatomic, strong) NSTimer *timerRight;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic) BOOL gameOver;
@end

@implementation GameViewController

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
    self.tijdLabel.font = [UIFont fontWithName:@"Spacera W01" size:17.0f];
    self.motionManager = [[CMMotionManager alloc] init];
    if (self.motionManager.accelerometerAvailable){
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
        self.leftButtonImg.hidden = YES;
        self.rightButtonImg.hidden = YES;
        [self.motionManager setAccelerometerUpdateInterval:.01];
        [self.motionManager startAccelerometerUpdates];
        [self performSelectorInBackground:@selector(updateLocation) withObject:nil];
    }else {
        
    }
    [self performSelectorInBackground:@selector(updateTijd) withObject:nil];
    self.objects = [NSMutableArray array];
    [self addObject];
    [self performSelectorInBackground:@selector(randomAddObjects) withObject:nil];
    UILongPressGestureRecognizer *longPress_gr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longLeft:)];
    longPress_gr.minimumPressDuration = 0.0001;
    [self.leftButton addGestureRecognizer:longPress_gr];
    
    UILongPressGestureRecognizer *longPress_gr2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longRight:)];
    longPress_gr2.minimumPressDuration = 0.0001;
    [self.rightButton addGestureRecognizer:longPress_gr2];
    // Do any additional setup after loading the view from its nib.
}
- (void)updateLocation {
    while (self.gameOver == NO) {
        [NSThread sleepForTimeInterval:.01];
        CMAcceleration acceleration = self.motionManager.accelerometerData.acceleration;
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect rocketFrame = self.rocketView.frame;
            rocketFrame.origin.x += acceleration.x*25;
            if (rocketFrame.origin.x < 0)
                rocketFrame.origin.x = 0;
            if (rocketFrame.origin.x > [[self.rocketView superview] frame].size.width-rocketFrame.size.width)
                rocketFrame.origin.x = [[self.rocketView superview] frame].size.width-rocketFrame.size.width;
            [self.rocketView setFrame:rocketFrame];
        });
    }
}
- (void)randomAddObjects {
    while (self.gameOver == NO) {
        float randomTime = randomFloat(3.0, 4.5);
        [NSThread sleepForTimeInterval:randomTime];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.gameOver)
                [self addObject];
        });
    }
}
- (void)updateTijd {
    NSInteger tijd = 0;
     while (1 == 1) {
         sleep(1);
         tijd++;
         NSString *tijdText;
         if (tijd < 10)
             tijdText = [NSString stringWithFormat:@"00:0%d", tijd];
         else if (tijd < 60)
             tijdText = [NSString stringWithFormat:@"00:%d", tijd];
         else if (tijd < 600){
             NSInteger minuten = tijd/60;
             NSInteger seconden = tijd-(minuten*60);
             if (seconden < 10)
                 tijdText = [NSString stringWithFormat:@"0%d:0%d", minuten, seconden];
             else if (seconden < 60)
                 tijdText = [NSString stringWithFormat:@"0%d:%d", minuten, seconden];
         }else {
             NSInteger minuten = tijd/60;
             NSInteger seconden = tijd-(minuten*60);
             if (seconden < 10)
                 tijdText = [NSString stringWithFormat:@"%d:0%d", minuten, seconden];
             else if (seconden < 60)
                 tijdText = [NSString stringWithFormat:@"%d:%d", minuten, seconden];
         }
         dispatch_async(dispatch_get_main_queue(), ^{
            self.tijdLabel.text = tijdText;
         });
     }
}
- (void)checkIfHit {
    while (1 == 1) {
        [NSThread sleepForTimeInterval:.05];
        for (UIView *object in [self.objects copy]) {
            BOOL hits = [self object:object hitObject:self.rocketView];
            if (hits){
                [object setBackgroundColor:[UIColor redColor]];
            }
        }
    }
}
- (BOOL)object:(UIView *)object1 hitObject:(UIView *)object2 {
    CGRect object1Frame = [object1 frame];
    CGRect object2Frame = [object2 frame];
    object2Frame.size.height = 96.0f;
    if (CGRectIntersectsRect(object1Frame, object2Frame))
        return YES;
    return NO;
}

- (void)addObject {
    UIView *object = [[UIView alloc] initWithFrame:CGRectMake([self randomXwithWidthForObject:40 forSuperView:self.gameView.frame.size.width], 0, 40, 40)];
    UIImage *planeetImage =[UIImage imageNamed:[NSString stringWithFormat:@"planeet%d.png", arc4random() % 6 + 1]];
    object.backgroundColor = [UIColor clearColor];
    CGRect objectFrame = [object frame];
    objectFrame.size.width = planeetImage.size.width/2;
    objectFrame.size.height = planeetImage.size.height/2;
    objectFrame.origin.x = [self randomXwithWidthForObject:objectFrame.size.width forSuperView:self.gameView.frame.size.width];
    objectFrame.origin.y = -200;
    [object setFrame:objectFrame];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, objectFrame.size.width, objectFrame.size.height)];
    imageView.image = planeetImage;
    //[object setBackgroundColor:[UIColor blackColor]];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [object addSubview:imageView];
    object.tag = 5;
    [self.gameView addSubview:object];
    [self.objects addObject:object];
    [self performSelectorInBackground:@selector(objectAnimation:) withObject:object];
}
- (void)objectAnimation:(UIView *)object {
    NSInteger times = 0;
    float timeToSleep = 2.5/(self.gameView.frame.size.height-object.frame.origin.x);
    while (self.gameView.frame.size.height >= object.frame.origin.y) {
        if ([object tag] == 1){
            
        }else {
            if ([self object:object hitObject:self.rocketView]){
                if (!self.gameOver){
                    [object setTag:6];
                    [self setGameOver:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:@"Game over" message:@"You are game over!" delegate:self cancelButtonTitle:@"Try again!" otherButtonTitles:nil] show];
                    });
                }
            }if (self.gameView.frame.size.height <= object.frame.origin.y) {
                [object removeFromSuperview];
                [self.objects removeObject:object];
            }
            if ((![self object:object hitObject:self.rocketView]) && (!(self.gameView.frame.size.height <= object.frame.origin.y))) {
                [NSThread sleepForTimeInterval:timeToSleep];
                times++;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [object setFrame:CGRectMake(object.frame.origin.x, object.frame.origin.y+1, object.frame.size.width, object.frame.size.height)];
                    [object setNeedsDisplay];
                });
            }
        }
    }
}
- (NSInteger)randomXwithWidthForObject:(NSInteger)widthObject forSuperView:(NSInteger)widthSuperView {
    NSInteger minimumX = 0;
    NSInteger maximumX = widthSuperView-widthObject;
    return arc4random() % maximumX + minimumX;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)left {
    CGRect rocketFrame = [self.rocketView frame];
    rocketFrame.origin.x = rocketFrame.origin.x-10;
    if (rocketFrame.origin.x < 0)
        rocketFrame.origin.x = 0;
    [self.rocketView setFrame:rocketFrame];
}
- (void)right {
    CGRect rocketFrame = [self.rocketView frame];
    rocketFrame.origin.x = rocketFrame.origin.x+10;
    if (rocketFrame.origin.x > [[self.rocketView superview] frame].size.width-rocketFrame.size.width)
        rocketFrame.origin.x = [[self.rocketView superview] frame].size.width-rocketFrame.size.width;
    [self.rocketView setFrame:rocketFrame];
}
- (void)longLeft:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.timerLeft = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(left) userInfo:nil repeats:YES];
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        [self.timerLeft invalidate];
    }
}
- (void)longRight:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.timerRight = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(right) userInfo:nil repeats:YES];
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        [self.timerRight invalidate];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] window].rootViewController = [[GameViewController alloc] init];
}
@end

//
//  TTSFunView.m
//  TouchTest
//
//  Created by B.J. Ray on 12/12/12.
//  Copyright (c) 2012 Thought Syndicate. All rights reserved.
//

#import "TTSFunView.h"
#import <AVFoundation/AVFoundation.h>
#define kTouchRadius 30.0
#define kRed 255.0
#define kBlue 255.0

@interface TTSFunView()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer1;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer2;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer3;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer4;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer5;
@end

@implementation TTSFunView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        self.currentColor = [UIColor blackColor];
        self.startPoint = CGPointMake(250.0, 50.0);
        self.endPoint = CGPointMake(50.0, 350.0);
//        self.coldTouchColor = [UIColor colorWithRed:255.0f green:0.0f blue:0.0f alpha:0.35f];
//        self.hotTouchColor = [UIColor colorWithRed:0.0f green:0.0f blue:255.0f alpha:0.35f];
        self.touchColor = [UIColor colorWithRed:0.0f green:0.0f blue:255.0f alpha:0.1f];
        self.inRange = NO;

        
        UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(doDoubleTap)];
        tapper.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tapper];
        
        
        
        NSURL *url1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"s1" ofType:@"mp3"]];
        NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"s2" ofType:@"mp3"]];
        NSURL *url3 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"s3" ofType:@"mp3"]];
        NSURL *url4 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"s4" ofType:@"mp3"]];
        NSURL *url5 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"s5" ofType:@"mp3"]];
        self.audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:nil];
        [self.audioPlayer1 prepareToPlay];
        self.audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
        [self.audioPlayer2 prepareToPlay];
        self.audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:url3 error:nil];
        [self.audioPlayer3 prepareToPlay];
        self.audioPlayer4 = [[AVAudioPlayer alloc] initWithContentsOfURL:url4 error:nil];
        [self.audioPlayer4 prepareToPlay];
        self.audioPlayer5 = [[AVAudioPlayer alloc] initWithContentsOfURL:url5 error:nil];
        [self.audioPlayer5 prepareToPlay];
    }
    return self;
}

#pragma mark - Drawing methods

- (void)drawRect:(CGRect)rect
{
    CGRect touchRect = CGRectMake(self.currentTouch.x-(kTouchRadius/2.0), self.currentTouch.y-(kTouchRadius/2.0), kTouchRadius, kTouchRadius);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawPointsInContext:context];
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, self.currentColor.CGColor);
    
    CGContextMoveToPoint(context, self.firstTouch.x, self.firstTouch.y);
    CGContextAddLineToPoint(context, self.lastTouch.x, self.lastTouch.y);
    CGContextStrokePath(context);
    
    //draw circle
    CGContextSetFillColorWithColor(context, self.touchColor.CGColor);
    CGContextAddEllipseInRect(context, touchRect);
    
    if (self.inRange) {
        CGContextDrawPath(context, kCGPathFillStroke);
    } else {
        CGContextDrawPath(context, kCGPathFill);
    }
    
}

- (void)drawPointsInContext: (CGContextRef) context {
    CGRect dotRect;
    float r = 10.0;
    [[UIColor blackColor] set];
    
    dotRect = CGRectMake(self.startPoint.x, self.startPoint.y, r, r);
    CGContextAddEllipseInRect(context, dotRect);
    CGContextDrawPath(context, kCGPathFill);
    
    dotRect = CGRectMake(self.endPoint.x, self.endPoint.y, r, r);
    CGContextAddEllipseInRect(context, dotRect);
    CGContextDrawPath(context, kCGPathFill);
}



#pragma mark - Touch methods


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _firstTouch = [touch locationInView:self];
    _lastTouch = [touch locationInView:self];
    _currentTouch = [touch locationInView:self];
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    _currentTouch = [touch locationInView:self];
    [self checkDistanceFromTouch:_currentTouch];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    _currentTouch = CGPointMake(0.0, 0.0);
    [self setNeedsDisplay];
    
    int r = arc4random() % 4 + 1;
    [self.audioPlayer1 stop];
    [self.audioPlayer2 stop];
    [self.audioPlayer3 stop];
    [self.audioPlayer4 stop];
    [self.audioPlayer5 stop];
    
    switch (r) {
        case 1:
            [self.audioPlayer1 play];
            NSLog(@"play 1");
            break;
        case 2:
            [self.audioPlayer2 play];
            NSLog(@"play 2");
            break;
        case 3:
            [self.audioPlayer3 play];
            NSLog(@"play 3");
            break;
        case 4:
            [self.audioPlayer4 play];
            NSLog(@"play 4");
            break;
        case 5:
            [self.audioPlayer5 play];
            NSLog(@"play 5");
            break;
        default:
            break;
    }
}

- (void)doDoubleTap {
    NSLog(@"Double Tap!");
    
}

#pragma mark Helper Methods
-(void)checkDistanceFromTouch:(CGPoint)touch {
    float x1 = touch.x;
    float y1 = touch.y;
    float x2 = self.endPoint.x;
    float y2 = self.endPoint.y;
    
    float p1 = powf((x2-x1), 2);
    float p2 = powf((y2-y1), 2);
    float distance = sqrtf(p1 + p2);
    float cR = 0.0;
    float cB = 0.0;
    float cG = 0.0;
    float a = 0.2;
    
    
    if (distance <= 255 && distance >= 20) {
        //light to darker blue...
        cR = 0.0;
        cG = 0.0;
        cB = 255.0;
//        a = (-0.7f/255.0f)*distance + 0.9f;
        a = 20/distance;
        self.inRange = NO;
        
//        NSLog(@"alpha: %f", a);
    } else if (distance < 20) {
        //switch to yellow when we are close!
        cR = 255.0;
        cG = 255.0;
        cB = 0.0;
        a = 0.6;
        self.inRange = YES;
    } else {
        cR = 0.0;
        cG = 0.0;
        cB = 255.0;
        a = 0.1;
        self.inRange = NO;
    }
    
    
    self.touchColor = [UIColor colorWithRed:cR green:cG blue:cB alpha:a];
    
}

@end

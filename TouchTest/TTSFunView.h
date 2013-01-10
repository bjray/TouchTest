//
//  TTSFunView.h
//  TouchTest
//
//  Created by B.J. Ray on 12/12/12.
//  Copyright (c) 2012 Thought Syndicate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTSFunView : UIView
@property (nonatomic)CGPoint firstTouch;
@property (nonatomic)CGPoint currentTouch;
@property (nonatomic)CGPoint lastTouch;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) UIColor *coldTouchColor;
@property (nonatomic, strong) UIColor *hotTouchColor;
@property (nonatomic, strong) UIColor *touchColor;
//@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic)CGPoint startPoint;
@property (nonatomic)CGPoint endPoint;
@property (nonatomic) BOOL inRange;
@end

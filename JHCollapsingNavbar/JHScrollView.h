//  JHCollapsingNavbar
//  JHScrollView.h
//
//  Created by Joshua Haines on 6/2/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHConstants.h"

@class JHCollapsingView;

@protocol JHScrollViewDelegate <NSObject>

-(UIScrollView *)setScrollView;

@end

@interface JHScrollView : UIScrollView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) JHCollapsingView *collapsingView;
@property (strong, nonatomic) NSArray *viewChildren;

@property (weak, nonatomic) id <JHScrollViewDelegate> jhDelegate;

@property (nonatomic) ScrollDirection scrollDirection;
@property (nonatomic) CGPoint previousOffset;
@property (nonatomic) CGPoint translation;
@property (nonatomic) CGPoint lastTranslation;


-(BOOL)isNearTop;

@end

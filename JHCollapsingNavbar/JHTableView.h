//  JHCollapsingNavbar
//  JHTableView.m
//
//  Created by Joshua Haines on 6/2/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHScrollView.h"

@class JHCollapsingView;

@interface JHTableView : UITableView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) JHCollapsingView *collapsingView;
@property (strong, nonatomic) NSArray *viewChildren;

@property (nonatomic) ScrollDirection scrollDirection;
@property (nonatomic) CGPoint previousOffset;
@property (nonatomic) CGPoint translation;
@property (nonatomic) CGPoint lastTranslation;


-(BOOL)isNearTop;

@end
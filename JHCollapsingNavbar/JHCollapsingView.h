//  JHCollapsingNavbar
//  JHCollapsingView.h
//
//  Created by Joshua Haines on 6/2/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHScrollView;
@class JHTableView;

@interface JHCollapsingView : UIView

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;

@property (nonatomic) BOOL isMoving;
@property (nonatomic) BOOL atTheBottom;
@property (nonatomic) BOOL atTheTop;
@property (nonatomic) CGFloat stoppingPoint;

-(void)displayViewWithChildren:(NSArray *)array withScrollView:(JHScrollView *)scrollView;
-(void)displayViewWithChildren:(NSArray *)array withTableView:(JHTableView *)tableView;
-(BOOL)checkIsAllowedToMove:(CGFloat)translation withGesture:(UIPanGestureRecognizer *)gesture withScrollView:(JHScrollView *)scrollView;
-(BOOL)checkIsAllowedToMove:(CGFloat)translation withGesture:(UIPanGestureRecognizer *)gesture withTableView:(JHTableView *)tableView;
-(void)setFinalAlphaValues:(NSArray *)array;
-(void)snapViewWithTableView:(JHTableView *)tableView andPanGesture:(UIPanGestureRecognizer *)panGesture;
-(void)snapViewWithScrollView:(JHScrollView *)scrollView andPanGesture:(UIPanGestureRecognizer *)panGesture;
-(CGFloat)checkTopConstraint:(CGFloat)newlyProposedConstraint;

@end

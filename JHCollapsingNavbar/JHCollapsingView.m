//  JHCollapsingNavbar
//  JHTableView.m
//
//  Created by Joshua Haines on 6/2/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import "JHCollapsingView.h"
#import "JHScrollView.h"
#import "JHTableView.h"

@implementation JHCollapsingView

-(instancetype)init {
    self = [super init];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

-(void)displayView:(NSArray *)array {
    if (self.atTheTop) {
        
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            self.topConstraint.constant = 0;
            for (UIView *object in array) {
                object.alpha = 1;
            }
            [self layoutIfNeeded];
        }];
    }
}

-(BOOL)checkIsAllowedToMove:(CGFloat)translation withGesture:(UIPanGestureRecognizer *)gesture withScrollView:(JHScrollView *)scrollView {
    if (self.topConstraint.constant < 0 && self.topConstraint.constant > -self.frame.size.height) {
        return YES;
    }
    else if (![scrollView isNearTop]) {
        if (translation > 0 && scrollView.scrollDirection == ScrollDirectionDown) {
            return [gesture velocityInView:scrollView].y > 400;
        }
        else return scrollView.scrollDirection == ScrollDirectionUp;
    }
    else return [scrollView isNearTop];
}

-(BOOL)checkIsAllowedToMove:(CGFloat)translation withGesture:(UIPanGestureRecognizer *)gesture withTableView:(JHTableView *)tableView {
    if (self.topConstraint.constant < 0 && self.topConstraint.constant > -self.frame.size.height) {
        return YES;
    }
    else if (![tableView isNearTop]) {
        if (translation > 0 && tableView.scrollDirection == ScrollDirectionDown) {
            return [gesture velocityInView:tableView].y > 400;
        }
        else return tableView.scrollDirection == ScrollDirectionUp;
    }
    else return [tableView isNearTop];
}

-(void)setFinalAlphaValues:(NSArray *)array {
    if (self.topConstraint.constant == -self.frame.size.height) {
        for (UIView *object in array) {
            object.alpha = 0;
        }
    } else if (self.topConstraint.constant == 0) {
        for (UIView *object in array) {
            object.alpha = 1;
        }
    }
}

-(void)snapViewWithTableView:(JHTableView *)tableView andPanGesture:(UIPanGestureRecognizer *)panGesture {
    if (self.topConstraint.constant < 0 && self.topConstraint.constant > -(self.frame.size.height/2)) {
        
        [panGesture setEnabled:NO];
        [tableView.panGestureRecognizer setEnabled:NO];
        
        self.topConstraint.constant = 0;
        [UIView animateWithDuration:0.3 animations:^{
            for (UIView *object in tableView.viewChildren) {
                object.alpha = 1;
            }
            
            [self layoutIfNeeded];
            [tableView layoutIfNeeded]; // This is needed so that the tableView doesn't abruptly change
        } completion:^(BOOL finished) {
            if (finished) {
                [panGesture setEnabled:YES];
                [tableView.panGestureRecognizer setEnabled:YES];
                self.isMoving = NO;
            }
        }];
    }
    else if (self.topConstraint.constant <= -(self.frame.size.height/2) && self.topConstraint.constant > -self.frame.size.height) {
        
        [panGesture setEnabled:NO];
        [tableView.panGestureRecognizer setEnabled:NO];
        
        self.topConstraint.constant = -self.frame.size.height;
        [UIView animateWithDuration:0.3 animations:^{
            for (UIView *object in tableView.viewChildren) {
                object.alpha = 0;
            }
            
            [self layoutIfNeeded];
            [tableView layoutIfNeeded]; // This is needed so that the tableView doesn't abruptly change
        } completion:^(BOOL finished) {
            if (finished) {
                [panGesture setEnabled:YES];
                [tableView.panGestureRecognizer setEnabled:YES];
                self.isMoving = NO;
            }
        }];
    }
}

-(void)snapViewWithScrollView:(JHScrollView *)scrollView andPanGesture:(UIPanGestureRecognizer *)panGesture {
    if (self.topConstraint.constant < 0 && self.topConstraint.constant > -(self.frame.size.height/2)) {
        
        [panGesture setEnabled:NO];
        [scrollView.panGestureRecognizer setEnabled:NO];
        
        self.topConstraint.constant = 0;
        [UIView animateWithDuration:0.3 animations:^{
            for (UIView *object in scrollView.viewChildren) {
                object.alpha = 1;
            }
            
            [self layoutIfNeeded];
            [scrollView layoutIfNeeded]; // This is needed so that the tableView doesn't abruptly change
        } completion:^(BOOL finished) {
            if (finished) {
                [panGesture setEnabled:YES];
                [scrollView.panGestureRecognizer setEnabled:YES];
                self.isMoving = NO;
            }
        }];
    }
    else if (self.topConstraint.constant <= -(self.frame.size.height/2) && self.topConstraint.constant > -self.frame.size.height) {
        
        [panGesture setEnabled:NO];
        [scrollView.panGestureRecognizer setEnabled:NO];
        
        self.topConstraint.constant = -self.frame.size.height;
        [UIView animateWithDuration:0.3 animations:^{
            for (UIView *object in scrollView.viewChildren) {
                object.alpha = 0;
            }
            
            [self layoutIfNeeded];
            [scrollView layoutIfNeeded]; // This is needed so that the tableView doesn't abruptly change
        } completion:^(BOOL finished) {
            if (finished) {
                [panGesture setEnabled:YES];
                [scrollView.panGestureRecognizer setEnabled:YES];
                self.isMoving = NO;
            }
        }];
    }
    
}

-(CGFloat)checkTopConstraint:(CGFloat)newlyProposedConstraint {
    if (newlyProposedConstraint <= -self.frame.size.height) {
        newlyProposedConstraint = -self.frame.size.height;
        self.atTheTop = YES;
        self.isMoving = NO;
    } else {
        self.atTheTop = NO;
    }
    
    if (newlyProposedConstraint >= 0) {
        newlyProposedConstraint = 0;
        self.atTheBottom = YES;
        self.isMoving = NO;
    } else {
        self.atTheBottom = NO;
    }
    
    return newlyProposedConstraint;
}

@end

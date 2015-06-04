//  JHCollapsingNavbar
//  JHTableView.m
//
//  Created by Joshua Haines on 6/2/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import "JHTableView.h"
#import "JHCollapsingView.h"

@implementation JHTableView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPan:)];
        self.panGesture.delegate = self;
        [self addGestureRecognizer:self.panGesture];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPan:)];
        self.panGesture.delegate = self;
        [self addGestureRecognizer:self.panGesture];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPan:)];
        self.panGesture.delegate = self;
        [self addGestureRecognizer:self.panGesture];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPan:)];
        self.panGesture.delegate = self;
        [self addGestureRecognizer:self.panGesture];
    }
    return self;
}

-(instancetype)initWithCollapsingView:(JHCollapsingView *)view andChildren:(NSArray *)array {
    self = [super init];
    if (self) {
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPan:)];
        self.panGesture.delegate = self;
        [self addGestureRecognizer:self.panGesture];
        
        self.collapsingView = view;
        self.viewChildren = array;
    }
    return self;
}

-(BOOL)isNearTop {
    // If user is within 150 points from the top of the scrollview, return yes
    return self.contentOffset.y <= 150;
}

-(void)userDidPan:(UIPanGestureRecognizer *)panGesture {
    // Moves the collapsing view on user pan.
    if (panGesture.state != UIGestureRecognizerStateEnded) {
        
        self.translation = [panGesture translationInView:self];
        CGFloat delta = self.lastTranslation.y - self.translation.y;
        
        if (delta > 0) {
            self.scrollDirection = ScrollDirectionUp;
        } else if (delta < 0) {
            self.scrollDirection = ScrollDirectionDown;
        } else {
            self.scrollDirection = ScrollDirectionNone;
        }
        
        if ([self.collapsingView checkIsAllowedToMove:self.translation.y withGesture:panGesture withTableView:self]) {
            CGFloat proposedConstraint;
            
            if (!self.collapsingView.isMoving) {
                if (self.contentOffset.y < 0 && self.collapsingView.atTheBottom) {
                    self.lastTranslation = self.translation;
                    return;
                } else {
                    self.previousOffset = self.contentOffset;
                    self.collapsingView.isMoving = YES;
                }
            }
            proposedConstraint = [self.collapsingView checkTopConstraint:(self.collapsingView.topConstraint.constant - delta)];
            self.collapsingView.topConstraint.constant = proposedConstraint;
            
            if (!self.collapsingView.atTheTop && !self.collapsingView.atTheBottom) {
                self.contentOffset = self.previousOffset;
            }
            
            for (UIView *object in self.viewChildren) {
                object.alpha = 1 - fabs(self.collapsingView.topConstraint.constant/(self.collapsingView.frame.size.height/2));
            }
        }
        self.lastTranslation = self.translation;
    } else {
        /* When the user stops panning, snap the view if necessary, set the final alpha values of
         the views children, and reset translation and lastTranslation to zero */
        [self.collapsingView snapViewWithTableView:self andPanGesture:self.panGesture];
        [self.collapsingView setFinalAlphaValues:self.viewChildren];
        self.lastTranslation = CGPointZero;
        self.translation = CGPointZero;
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end

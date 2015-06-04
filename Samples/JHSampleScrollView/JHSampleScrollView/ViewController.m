//
//  ViewController.m
//  JHSampleScrollView
//
//  Created by Joshua Haines on 6/3/15.
//  Copyright (c) 2015 Joshua Haines. All rights reserved.
//

#import "ViewController.h"
#import "JHCollapsingNavbar/JHCollapsingNavbar.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet JHScrollView *scrollView;
@property (weak, nonatomic) IBOutlet JHCollapsingView *collapsingView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the top constraint of my collapsing view
    [self.collapsingView setTopConstraint:self.topConstraint];
    
    // Tell the scroll view which view is my collapsing view
    [self.scrollView setCollapsingView:self.collapsingView];
    
    // Set children UI elements of the collapsing view
    [self.scrollView setViewChildren:@[self.titleLabel, self.leftButton, self.rightButton]];
    
    self.scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    // If the user taps the status bar to scroll all the way up, then display the collapsing view
    [self.collapsingView displayViewWithChildren:@[self.titleLabel, self.leftButton, self.rightButton] withScrollView:self.scrollView];
}

@end

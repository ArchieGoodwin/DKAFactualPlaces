//
//  DKANavVC.m
//  LookAround.iOS7
//
//  Created by Nero Wolfe on 21/10/13.
//  Copyright (c) 2013 Sergey Dikarev. All rights reserved.
//

#import "DKANavVC.h"

@interface DKANavVC ()

@end

@implementation DKANavVC

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
    
    [self.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    
    UIColor *barColour = [UIColor colorWithRed:0.24f green:0.20f blue:0.6f alpha:1.00f];
    UIView *colourView = [[UIView alloc] initWithFrame:CGRectMake(0.f, -20.f, 320.f, 64.f)];
    colourView.opaque = NO;
    colourView.alpha = .96f;
    colourView.backgroundColor = barColour;
    
    self.navigationBar.barTintColor = barColour;
    
    [self.navigationBar.layer insertSublayer:colourView.layer atIndex:1];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

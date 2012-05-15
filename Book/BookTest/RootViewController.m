//
//  RootViewController.m
//  BookTest
//
//  Created by Vincent Le Jeune on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "KCObjectRotationView.h"

@interface RootViewController ()

@end

@implementation RootViewController

#define kTotalImages 24

- (void)loadView
{
    [super loadView];
    
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor grayColor];
        
    /** 
     * ObjectRotation View.
     **/
    NSMutableArray *imagesArray = [NSMutableArray arrayWithCapacity:kTotalImages];
    for (int i = 0; i <= kTotalImages; i++) {
        [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Renders_Test_360_%.4d.png", i]]];
    }
    
    CGRect frame = CGRectMake(352, 264, 320, 240);
    
    KCObjectRotationView *objectRotationView = [[KCObjectRotationView alloc] initWithFrame:frame
                                                                          andImagesArray:imagesArray];
    
    [self.view addSubview:objectRotationView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Allow landscape orientation only.
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
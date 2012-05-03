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

- (void)loadView
{
    [super loadView];
    
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor grayColor];
        
    /** ObjectRotation View **/
    NSArray *imagesArray = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"Renders_Test_360_0000.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0001.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0002.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0003.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0004.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0005.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0006.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0007.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0008.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0009.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0010.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0011.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0012.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0013.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0014.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0015.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0016.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0017.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0018.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0019.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0020.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0021.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0022.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0023.png"],
                            [UIImage imageNamed:@"Renders_Test_360_0024.png"],
                            nil];
    /// could be placed in PList
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

//
//  KCObjectRotationView.h
//  BookTest
//
//  Created by Vincent Le Jeune on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCObjectRotationView : UIView <UIGestureRecognizerDelegate> {
    
    NSArray *objectImagesArray;
    UIImageView *rotationView;
    
    // Gesture
    UIPanGestureRecognizer *rotationGestureRecognizer;
    int currentImageOffset;
    
    // Acceleration
    int numberOfMoves;
    NSTimer *accerationTimer;
    float accelerationDelay;
    int direction;
}

@property (nonatomic, strong) NSArray *objectImagesArray;

- (id)initWithFrame:(CGRect)frame andImagesArray:(NSArray *)imagesArray;

- (void)swipeLeft;
- (void)swipeRight;
- (void)performAcceleration;

@end

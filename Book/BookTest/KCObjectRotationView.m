//
//  KCObjectRotationView.m
//  BookTest
//
//  Created by Vincent Le Jeune on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KCObjectRotationView.h"
#import <QuartzCore/QuartzCore.h>

#include <math.h>

#define kMinTranslationPixel 2
#define kAccelerationMaxValues 3
#define SWIPE_THRESHOLD 1000.0f

#define kAccelerationDirectionRight 0
#define kAccelerationDirectionLeft 1

@implementation KCObjectRotationView

@synthesize objectImagesArray;

- (id)initWithFrame:(CGRect)frame andImagesArray:(NSArray *)imagesArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.objectImagesArray = imagesArray;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        // Init.
        currentImageOffset = 0;
        
        // Display initial image.
        rotationView = [[UIImageView alloc] initWithImage:[imagesArray objectAtIndex:currentImageOffset]];
        
        // Add custom swipe gesture recognizer.
        rotationGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
        [self addGestureRecognizer:rotationGestureRecognizer];
        
        [self addSubview:rotationView];
    }
    return self;
}

#pragma mark - Swipe gesture

- (void)handleRotationGesture:(UIPanGestureRecognizer *)rotationGesture
{
    if (rotationGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [rotationGesture translationInView:rotationGesture.view];
        
        // Left.
        if (translation.x < -kMinTranslationPixel)
        {
            [self swipeLeft];
            
            // Clear translation.
            [rotationGesture setTranslation:CGPointZero inView:rotationGesture.view];
            ///NSLog(@"[%i][%f]", currentImageOffset, translation.x);            
        }
        // Right.
        else if (translation.x > kMinTranslationPixel)
        {
            [self swipeRight];
            
            // Clear translation.
            [rotationGesture setTranslation:CGPointZero inView:rotationGesture.view];
            ///NSLog(@"[%i][%f]", currentImageOffset, translation.x);
        }
    }
    else if (rotationGesture.state == UIGestureRecognizerStateEnded)
    {
        //
        CGPoint velocity = [rotationGesture velocityInView:rotationGesture.view];
        
        numberOfMoves = (int)abs(floorf(velocity.x / SWIPE_THRESHOLD));
        accelerationDelay = 0.1;
        
        if (velocity.x < -SWIPE_THRESHOLD)
        {
            NSLog(@"swipe to the left");
            
            direction = kAccelerationDirectionLeft;
            [self performAcceleration];
            
        }
        else if (velocity.x > SWIPE_THRESHOLD)
        {
            NSLog(@"swipe to the right");
            
            direction = kAccelerationDirectionRight;
            [self performAcceleration];
        }
        
        NSLog(@"velocity: %f", velocity.x);
    }
}

- (void)performAcceleration
{
    NSLog(@"accelerationDelay: %f, numberOfMoves: %i", accelerationDelay, numberOfMoves);
    
    // Clear timer.
    [accerationTimer invalidate];
    accerationTimer = nil;    
    
    if (accelerationDelay > 1.0f/numberOfMoves)
    {
        return;
    } else
    {
        if (direction == kAccelerationDirectionLeft)
        {
            [self swipeLeft];
        }
        else if (direction == kAccelerationDirectionRight) {
            [self swipeRight];
        }
        
        // Wait n' seconds.
        accerationTimer = [NSTimer scheduledTimerWithTimeInterval:accelerationDelay target:self selector:@selector(performAcceleration) userInfo:nil repeats:NO];
    }
    
    // Increase delay. WRONG!!
    accelerationDelay += (accelerationDelay / numberOfMoves) * (1.2+accelerationDelay);
}

- (void)swipeLeft
{
    if (++currentImageOffset > ([self.objectImagesArray count] - 1)) {
        currentImageOffset = 0;
    }
    
    [rotationView setImage:[objectImagesArray objectAtIndex:currentImageOffset]];
}

- (void)swipeRight
{
    if (--currentImageOffset < 0) {
        currentImageOffset = [self.objectImagesArray count] - 1;
    }
    
    [rotationView setImage:[objectImagesArray objectAtIndex:currentImageOffset]];
}

#pragma mark - Memory management

- (void)dealloc
{
    self.objectImagesArray = nil;
}

@end

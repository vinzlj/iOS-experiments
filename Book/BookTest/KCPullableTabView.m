//
//  KCPullableTabView.m
//  BookTest
//
//  Created by Vincent Le Jeune on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KCPullableTabView.h"

#define windowWidth 1024.0
#define windowHeight 768.0

#define kExpandAnimationDuration 0.5
#define kSwipeTreshold 1000.0
#define kTabStateRetracted 0
#define kTabStateExpanded 1

@implementation KCPullableTabView

- (id)initWithContentView:(UIView *)contentView andTabView:(UIView *)tabView atPosition:(KCPosition)position
{
    // Define framesize.
    CGSize frameSize;
    if (position == KCPositionTop || position == KCPositionBottom)
        frameSize = CGSizeMake(contentView.frame.size.width, contentView.frame.size.height + tabView.frame.size.height);
    if (position == KCPositionLeft || position == KCPositionRight)
        frameSize = CGSizeMake(contentView.frame.size.width + tabView.frame.size.width, contentView.frame.size.height);
    
    // Define frame position.
    CGPoint framePosition;
    if (position == KCPositionTop || position == KCPositionBottom)
    {
        framePosition.x = (windowWidth / 2) - (frameSize.width / 2);
        if (position == KCPositionTop)      framePosition.y = 0;
        if (position == KCPositionBottom)   framePosition.y = windowHeight - frameSize.height;
    }
    if (position == KCPositionLeft || position == KCPositionRight)
    {
        framePosition.y = (windowHeight / 2) - (frameSize.height / 2);             /// BE CAREFUL WITH STATUS BAR -20px
        if (position == KCPositionLeft)     framePosition.x = 0;
        if (position == KCPositionRight)    framePosition.x = windowWidth - frameSize.width;
    }
    
    self = [super initWithFrame:CGRectMake(framePosition.x, framePosition.y, frameSize.width, frameSize.height)];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        // Shift views according to specified coordinates && positions.
        if (position == KCPositionTop)
            tabView.frame = CGRectMake(tabView.frame.origin.x, contentView.frame.size.height, tabView.frame.size.width, tabView.frame.size.height);
        if (position == KCPositionLeft)
            tabView.frame = CGRectMake(contentView.frame.size.width, tabView.frame.origin.y, tabView.frame.size.width, tabView.frame.size.height);
        if (position == KCPositionRight) {
            contentView.frame = CGRectMake(tabView.frame.size.width, 0, contentView.frame.size.width, contentView.frame.size.height);
            tabView.frame = CGRectMake(0, tabView.frame.origin.y, tabView.frame.size.width, tabView.frame.size.height);
        }
        if (position == KCPositionBottom) {
            contentView.frame = CGRectMake(0, tabView.frame.size.height, contentView.frame.size.width, contentView.frame.size.height);
            tabView.frame = CGRectMake(tabView.frame.origin.x, 0, tabView.frame.size.width, tabView.frame.size.height);
        }
        
        
        _contentView = contentView;
        _tabView = tabView;
        _position = position;
        
        [self addSubview:_contentView];
        [self addSubview:_tabView];
        
        
        // Shift main view to hide contentView.
        if (position == KCPositionTop) {
            self.frame = CGRectMake(self.frame.origin.x, -_contentView.frame.size.height, self.frame.size.width, self.frame.size.height);
            
            minCenter = self.center.y;
            maxCenter = _contentView.frame.size.height - _tabView.frame.size.height;
        }
        if (position == KCPositionLeft) {
            self.frame = CGRectMake(-_contentView.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        
            minCenter = self.center.x;
            maxCenter = _contentView.frame.size.width - _tabView.frame.size.width;
        }
        if (position == KCPositionRight) {
            self.frame = CGRectMake(windowWidth - _tabView.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        
            maxCenter = self.center.x;
            minCenter = maxCenter - _contentView.frame.size.width;
        }
        if (position == KCPositionBottom) {
            self.frame = CGRectMake(self.frame.origin.x, windowHeight - _tabView.frame.size.height, self.frame.size.width, self.frame.size.height);
        
            maxCenter = self.center.y;
            minCenter = maxCenter - _contentView.frame.size.height;
        }
        
        
        /* Gestures */
        dragGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDragGesture:)];
        [_tabView addGestureRecognizer:dragGestureRecognizer];
        
        /* Init */
        tabState = kTabStateRetracted;
    }
    return self;
}

#pragma mark - Gestures handler

- (void)handleDragGesture:(UIPanGestureRecognizer *)dragGesture
{    
    if (dragGesture.state == UIGestureRecognizerStateBegan)
    {
        //NSLog(@"minCenter [%f]", minCenter);
        //NSLog(@"maxCenter [%f]", maxCenter);
    }
    else
    if (dragGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint touchTranslation = [dragGesture translationInView:self];
        
        // Calculate new center position.
        if (_position == KCPositionTop || _position == KCPositionBottom)
            newCenter = self.center.y + touchTranslation.y;
        if (_position == KCPositionLeft || _position == KCPositionRight)
            newCenter = self.center.x + touchTranslation.x;
        
        // Check if in bounds.
        if (newCenter >= minCenter &&
            newCenter <= maxCenter)
        {
            if (_position == KCPositionTop || _position == KCPositionBottom)
                self.center = CGPointMake(self.center.x, newCenter);
            if (_position == KCPositionLeft || _position == KCPositionRight)
                self.center = CGPointMake(newCenter, self.center.y);
        }
        
        [dragGesture setTranslation:CGPointZero inView:self];
    }
    else
    if (dragGesture.state == UIGestureRecognizerStateEnded)
    {
        
        // Check if movement is fast enough to expand.
        CGPoint velocity = [dragGesture velocityInView:self];
        BOOL isFastEnough;
        if (_position == KCPositionTop || _position == KCPositionBottom)
            if (tabState == kTabStateRetracted) {
                isFastEnough = (velocity.y > kSwipeTreshold);
            } else {
                isFastEnough = (velocity.y < -kSwipeTreshold);
            }
        if (_position == KCPositionLeft || _position == KCPositionRight)
            if (tabState == kTabStateRetracted) {
                isFastEnough = (velocity.x > kSwipeTreshold);
            } else {
                isFastEnough = (velocity.x < -kSwipeTreshold);
            }
        
        NSLog(@"velocity [%f] fastEnough:%@", velocity.y, (isFastEnough) ? @"YES" : @"NO");
        
        // Sticky animation.
        if (tabState == kTabStateRetracted) {
            
            if (newCenter > ((maxCenter - abs(minCenter)) / 2) || isFastEnough)
            {
                // Expand.
                [UIView animateWithDuration:kExpandAnimationDuration
                                 animations:^{
                                     self.center = [self getEndingMaxPoint];
                                     tabState = kTabStateExpanded;
                                 }];
            } else {
                // Back to original place.
                [UIView animateWithDuration:kExpandAnimationDuration
                                 animations:^{
                                     self.center = [self getEndingMinPoint];
                                 }];
            }
        } 
        else
            
        if (tabState == kTabStateExpanded) {
                
            if (newCenter < ((maxCenter - abs(minCenter)) / 2) || isFastEnough) {
                // Expand.
                [UIView animateWithDuration:kExpandAnimationDuration
                                 animations:^{
                                     self.center = [self getEndingMinPoint];
                                     tabState = kTabStateRetracted;
                                 }];
            } else {
                // Back to original place.
                [UIView animateWithDuration:kExpandAnimationDuration
                                 animations:^{
                                     self.center = [self getEndingMaxPoint];
                                 }];
            }
        }
    }
    
}

- (CGPoint)getEndingMinPoint
{
    CGPoint endingPoint;
    
    if (_position == KCPositionTop || _position == KCPositionBottom)
        endingPoint = CGPointMake(self.center.x, minCenter);
    if (_position == KCPositionLeft || _position == KCPositionRight)
        endingPoint = CGPointMake(minCenter, self.center.y);
    
    return endingPoint;
} 

- (CGPoint)getEndingMaxPoint 
{
    CGPoint endingPoint;
    
    if (_position == KCPositionTop || _position == KCPositionBottom)
        endingPoint = CGPointMake(self.center.x, maxCenter);
    if (_position == KCPositionLeft || _position == KCPositionRight)
        endingPoint = CGPointMake(maxCenter, self.center.y);
        
    return endingPoint;
}

@end

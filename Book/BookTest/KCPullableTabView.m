//
//  KCPullableTabView.m
//  BookTest
//
//  Created by Vincent Le Jeune on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KCPullableTabView.h"

@implementation KCPullableTabView

- (id)initWithInnerView:(UIView *)innerView andTabView:(UIView *)tabView atPosition:(KCPosition)position
{
    // Define framesize.
    CGSize frameSize;
    if (position == KCPositionTop || position == KCPositionBottom)
        frameSize = CGSizeMake(innerView.frame.size.width, innerView.frame.size.height + tabView.frame.size.height);
    if (position == KCPositionLeft || position == KCPositionRight)
        frameSize = CGSizeMake(innerView.frame.size.width + tabView.frame.size.width, innerView.frame.size.height);
    
    // Define frame position.
    CGPoint framePosition;
    if (position == KCPositionTop || position == KCPositionBottom)
    {
        framePosition.x = 512 - (frameSize.width / 2);
        if (position == KCPositionTop)      framePosition.y = 0;
        if (position == KCPositionBottom)   framePosition.y = 768 - frameSize.height;
    }
    if (position == KCPositionLeft || position == KCPositionRight)
    {
        framePosition.y = 384 - (frameSize.height / 2);
        if (position == KCPositionLeft)     framePosition.x = 0;
        if (position == KCPositionRight)    framePosition.x = 1024 - frameSize.width;
    }
    
    self = [super initWithFrame:CGRectMake(framePosition.x, framePosition.y, frameSize.width, frameSize.height)];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        [self addSubview:innerView];
        [self addSubview:tabView];
    }
    return self;
}

@end

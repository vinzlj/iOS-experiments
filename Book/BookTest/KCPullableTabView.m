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
        /*  if top: shift tabView at the bottom
            if left: shift tabView on the right
            if right: shift contentView on the right
            if bottom: shift contentView to bottom
         */
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
        if (position == KCPositionTop)
            self.frame = CGRectMake(self.frame.origin.x, -_contentView.frame.size.height, self.frame.size.width, self.frame.size.height);
        if (position == KCPositionLeft)
            self.frame = CGRectMake(-_contentView.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        if (position == KCPositionRight)
            self.frame = CGRectMake(windowWidth - _tabView.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        if (position == KCPositionBottom)
            self.frame = CGRectMake(self.frame.origin.x, windowHeight - _tabView.frame.size.height, self.frame.size.width, self.frame.size.height);
    }
    return self;
}

@end

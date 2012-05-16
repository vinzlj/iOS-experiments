//
//  KCPullableTabView.h
//  BookTest
//
//  Created by Vincent Le Jeune on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	KCPositionTop,
	KCPositionRight,
	KCPositionBottom,
    KCPositionLeft
} KCPosition;

@interface KCPullableTabView : UIView <UIGestureRecognizerDelegate> {
    UIView *_contentView;
    UIView *_tabView;
    KCPosition _position;
    
    // Gestures.
    UIPanGestureRecognizer *dragGestureRecognizer;
    CGFloat minCenter, maxCenter;
}

- (id)initWithContentView:(UIView *)contentView andTabView:(UIView *)tabView atPosition:(KCPosition)position;

@end

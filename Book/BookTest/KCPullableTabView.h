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

@interface KCPullableTabView : UIView

- (id)initWithInnerView:(UIView *)innerView andTabView:(UIView *)tabView atPosition:(KCPosition)position;

@end

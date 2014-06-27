//
//  ASScroll.h
//  ScrollView Source control
//
//  Created by Ahmed Salah on 12/14/13.
//  Copyright (c) 2013 Ahmed Salah. All rights reserved.
//

/**
 *  这里显示的是主界面的图片滑动的view,通常用于展示一些滑动的图片
    
 */
#import <UIKit/UIKit.h>
#import "StyledPageControl.h"


@interface ASScroll : UIView<UIScrollViewDelegate>
{
    float previousTouchPoint;
    StyledPageControl *pageControl;
    UIScrollView * scrollview ;
    BOOL didEndAnimate;
}
@property (retain ,nonatomic) NSMutableArray *arrOfImages;

@end

//
//  ASScroll.m
//  ScrollView Source control
//
//  Created by Ahmed Salah on 12/14/13.
//  Copyright (c) 2013 Ahmed Salah. All rights reserved.
//

#import "ASScroll.h"

@implementation ASScroll

@synthesize arrOfImages;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        // Initialization code
    }
    return self;
}

-(void)setArrOfImages:(NSMutableArray *)arr{
    
    arrOfImages = arr;
    pageControl = [[StyledPageControl alloc] init];
    pageControl.frame = CGRectMake(0, self.frame.size.height - 15, self.frame.size.width, 15);
    pageControl.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
    pageControl.numberOfPages = arrOfImages.count;
    pageControl.currentPage = 0;
    [pageControl setPageControlStyle:PageControlStyleDefault];
    [pageControl setCoreNormalColor:[UIColor colorWithWhite:0.6 alpha:0.5]];
    [pageControl setCoreSelectedColor:[UIColor grayColor]];
    
    
    scrollview = [[UIScrollView alloc]initWithFrame:self.frame];
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width * arrOfImages.count,scrollview.frame.size.height);
    [scrollview setDelegate:self];
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    for (int i =0; i<arrOfImages.count ; i++) {
        UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[arrOfImages objectAtIndex:i]]];
        imageview.frame = CGRectMake(0.0, 0.0,scrollview.frame.size.width , self.frame.size.height);
        imageview.contentMode = UIViewContentModeScaleAspectFill | UIViewContentModeScaleAspectFit;
        imageview.clipsToBounds = YES;
        
        [imageview setTag:i+1];
        if (i !=0) {
            imageview.alpha = 0;
        }
        [self addSubview:imageview];
        //[imageview release];
    }
    [pageControl addTarget:self
                    action:@selector(pgCntlChanged:)forControlEvents:UIControlEventValueChanged];
    [self performSelector:@selector(startAnimatingScrl) withObject:nil afterDelay:3.0];

    [self addSubview:scrollview];
    [self addSubview:pageControl];
}
- (void)startAnimatingScrl
{
    if (arrOfImages.count) {
        [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage +1)%arrOfImages.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
        [pageControl setCurrentPage:((pageControl.currentPage +1)%arrOfImages.count)];
        [self performSelector:@selector(startAnimatingScrl) withObject:nil  afterDelay:3.0];
    }
}
-(void) cancelScrollAnimation{
    didEndAnimate =YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimatingScrl) object:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self cancelScrollAnimation];
    previousTouchPoint = scrollView.contentOffset.x;
}

- (IBAction)pgCntlChanged:(UIPageControl *)sender {
    [scrollview scrollRectToVisible:CGRectMake(sender.currentPage*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
    [self cancelScrollAnimation];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [pageControl setCurrentPage:scrollview.bounds.origin.x/scrollview.frame.size.width];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
    
    int page = floor((scrollView.contentOffset.x - 320) / 320) + 1;
    float OldMin = 320*page;
    int Value = scrollView.contentOffset.x -OldMin;
    float alpha = (Value% 320) / 320.f;
    
    
    if (previousTouchPoint > scrollView.contentOffset.x)
        page = page+2;
    else
        page = page+1;

    UIView *nextPage = [scrollView.superview viewWithTag:page+1];
    UIView *previousPage = [scrollView.superview viewWithTag:page-1];
    UIView *currentPage = [scrollView.superview viewWithTag:page];
    
    if(previousTouchPoint <= scrollView.contentOffset.x){
        if ([currentPage isKindOfClass:[UIImageView class]])
            currentPage.alpha = 1-alpha;
        if ([nextPage isKindOfClass:[UIImageView class]])
            nextPage.alpha = alpha;
        if ([previousPage isKindOfClass:[UIImageView class]])
            previousPage.alpha = 0;
    }else if(page != 0){
        if ([currentPage isKindOfClass:[UIImageView class]])
            currentPage.alpha = alpha;
        if ([nextPage isKindOfClass:[UIImageView class]])
            nextPage.alpha = 0;
        if ([previousPage isKindOfClass:[UIImageView class]])
            previousPage.alpha = 1-alpha;
    }
    if (!didEndAnimate && pageControl.currentPage == 0) {
        for (UIView * imageView in self.subviews){
            if (imageView.tag !=1 && [imageView isKindOfClass:[UIImageView class]])
                imageView.alpha = 0;
            else if([imageView isKindOfClass:[UIImageView class]])
                imageView.alpha = 1 ;
        }
    }
    
}

-(void)dealloc{
    [self cancelScrollAnimation];
//    [arrOfImages release];
//    [pageControl release];
//    [scrollview release];
    //[super dealloc];
}

@end

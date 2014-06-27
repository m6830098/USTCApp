//
//  DetailViewController.h
//  USTCApp
//
//  Created by ChenHao on 6/12/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIWebViewDelegate>


@property (nonatomic, strong) NSString                *urlString;

//webview直接加载的是content,所以消耗的时间就是webview load的时间
- (void)LoadHtmlString:(NSString *)htmlString;


//虽然加载的也是content,但是要对字符串进行解析并且替换其中的代码

- (void)LoadContentString:(NSString *)contentString withPictureArray:(NSArray *)picArray;


@end

//
//  WebViewController.h
//  NavCtrl
//
//  Created by Tamar on 10/5/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIWebView *webPage;
@property (retain, nonatomic) NSURL *pageUrl;
@property (retain,nonatomic) WKWebView *webView;
-(void) setUrl:(NSString *)url;
@end

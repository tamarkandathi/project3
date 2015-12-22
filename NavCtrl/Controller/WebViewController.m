//
//  WebViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/5/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

-(void)setUrl:(NSString *)url {
    self.pageUrl = [NSURL URLWithString:url];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: self.pageUrl];
    [self.webView loadRequest:request];
    self.view = self.webView;
    self.webView.frame = self.view.frame;
}

- (void)dealloc {
    [_webPage release];
    [super dealloc];
}
@end

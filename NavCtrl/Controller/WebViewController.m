//
//  WebViewController.m
//  NavCtrl
//
//  Created by Tamar on 10/5/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

-(void)setUrl:(NSString *)url {
    self.pageUrl = [NSURL URLWithString:url];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: self.pageUrl];
    [self.webView loadRequest:request];
    self.view = self.webView;
    self.webView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_webPage release];
    [super dealloc];
}
@end

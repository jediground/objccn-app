//
//  DetailViewController.m
//  SwiftLanguage
//
//  Created by Moch Xiao on 2014-12-29.
//	Copyright (c) 2014 Moch Xiao (htt://github.com/atcuan).
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import "DetailViewController.h"
#import <SafariServices/SafariServices.h>

@interface DetailViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;

@end

@implementation DetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self customUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.hidesBarsOnSwipe = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	if (self.webView.isLoading) {
		[self.webView stopLoading];
	}
}

- (void)customUserInterface {
    
	NSString *bundleFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingFormat:@"/objccn.io/%@/index.html", self.bundleFileName];
	NSURL *fileURL = [NSURL URLWithString:bundleFilePath];
	NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
	[self.webView loadRequest:request];
	
	UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(forward:)];
	swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.bottomBar addGestureRecognizer:swipeLeft];
	
	UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
	[self.bottomBar addGestureRecognizer:swipeRight];
}

#pragma mark - 

- (void)webViewDidStartLoad:(UIWebView *)webView {
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	NSString *errorURLString = error.userInfo[@"NSErrorFailingURLStringKey"];
	NSString *errorMessage = [error localizedDescription];
	if (errorURLString) {
		errorMessage = [errorMessage stringByAppendingFormat:@"\nErrorURLString: %@", errorURLString];
	}
	
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
	[alert addAction:cancel];
	[self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		
		NSString *requestURLString  = [request.URL absoluteString];
		if ([requestURLString hasPrefix:@"http"]) {
            SFSafariViewController *sf = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:requestURLString]];
            [self.navigationController presentViewController:sf animated:YES completion:nil];
            
			return NO;
		}
		
		NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
		if ([requestURLString rangeOfString:resourcePath].location == NSNotFound) {
			NSString *last = [requestURLString lastPathComponent];
			
			NSRange chapterRange = [requestURLString rangeOfString:@"chapter"];
			if (chapterRange.location != NSNotFound) {
				NSUInteger location = chapterRange.location + chapterRange.length;
				NSString *chapterString = [requestURLString substringWithRange:NSMakeRange(location, 1)];
				last = [chapterString stringByAppendingString:last];
			}
			
			
			NSString *newRequestString = [resourcePath stringByAppendingPathComponent:last];
			newRequestString = [@"file://" stringByAppendingString:newRequestString];
			
			NSRange anchorLinkRange = [requestURLString rangeOfString:@"#"];
			if (anchorLinkRange.location != NSNotFound) {
				NSUInteger location = anchorLinkRange.location;
				NSString *anchorLinkString = [requestURLString substringFromIndex:location];
				[newRequestString stringByAppendingString:anchorLinkString];
			}
			
			NSURLRequest *newRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:newRequestString]];
			[self.webView loadRequest:newRequest];
			return NO;
		}
	}
	return YES;
}

#pragma mark - Actions

- (void)back:(id)sender {
	if ([self.webView canGoBack]) {
		[self.webView goBack];
	}
}

- (void)forward:(id)sender {
	if ([self.webView canGoForward]) {
		[self.webView goForward];
	}
}


@end

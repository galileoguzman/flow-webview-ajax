//
//  ViewController.m
//  WebView
//
//  Created by Galileo Guzman on 10/6/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.wvContent.delegate = self;
    
    
    [self initWithFile];
    
}

-(void)initWithFile{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.wvContent loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
}

-(void)initWithString{
    NSString* htmlContent = @"<html>\
    <head>\
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\
    <meta charset=\"utf-8\">\
    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\">\
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\
    <style>\
    #contenedor-iframe{\
    height: 100\%;\
    display: block;\
    }\
    </style>\
    </head> \
    <body> \
    <h1>Lovely webview </h1>\
    <div>\
    <iframe src=\"https://www.youtube.com/embed/JW5meKfy3fY\" frameborder=\"0\" allowtransparency=\"true\" style=\"border: none; width: 100%; height: 100%;\" id=\"iframe-recarga\">\
    </iframe>\
    </div>\
    </body>\
    </html>";
    
    
    [self.wvContent loadHTMLString:htmlContent baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"Start webview");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"Web viwe finished load");
    
    NSString *yourHTMLSourceCodeString = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
    NSLog(@"Content HTML \n\n %@", yourHTMLSourceCodeString);
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"ERRROR:\n%@", error.description);
    NSLog(@"ERRROR:\n%@", error.debugDescription);
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"There was a redirection from JS");
    
    // these need to match the values defined in your JavaScript
    NSString *myAppScheme = @"webview";
    NSString *myActionType = @"error";
    
    // ignore legit webview requests so they load normally
    if (![request.URL.scheme isEqualToString:myAppScheme]) {
        return YES;
    }
    
    // get the action from the path
    NSString *actionType = request.URL.host;
    // deserialize the request JSON
    NSString *jsonDictString = [request.URL.fragment stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    // look at the actionType and do whatever you want here
    if ([actionType isEqualToString:myActionType]) {
        // do something in response to your javascript action
        // if you used an action parameters dict, deserialize and inspect it here
        NSLog(@"Error own");
        [self showErrorWithString:jsonDictString];
    }
    
    
    // make sure to return NO so that your webview doesn't try to load your made-up URL
    return NO;
}

-(void)showErrorWithString:(NSString*)string{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"WebView" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated: YES completion: nil];
    
}

@end

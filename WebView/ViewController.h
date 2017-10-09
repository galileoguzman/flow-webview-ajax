//
//  ViewController.h
//  WebView
//
//  Created by Galileo Guzman on 10/6/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *wvContent;

@end


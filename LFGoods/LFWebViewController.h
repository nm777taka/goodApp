//
//  LFWebViewController.h
//  LFGoods
//
//  Created by 古田貴久 on 2014/06/12.
//  Copyright (c) 2014年 古田貴久. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFWebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

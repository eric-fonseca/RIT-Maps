//
//  BuildingDetailsVC.m
//  RIT Maps
//
//  Created by Eric Fonseca on 11/8/14.
//  Copyright (c) 2014 Eric Fonseca. All rights reserved.
//

#import "BuildingDetailsVC.h"

@interface BuildingDetailsVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BuildingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"template" ofType: @"html"];
    NSString *template = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSMutableString *html = [NSMutableString stringWithString:template];
    
    //if the building doesn't have a name, display no name found
    if (self.building.name == nil){
        [html replaceOccurrencesOfString:@"[[[name]]]" withString: @"No name found" options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    else{
        [html replaceOccurrencesOfString:@"[[[name]]]" withString: self.building.name options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    
    //if the building doesn't have an image, display a generic rit logo instead
    if([self.building.image isEqual: @"http://maps.rit.edu/images/photo-placeholder.gif"] || self.building.image == nil){
        [html replaceOccurrencesOfString:@"[[[image]]]" withString: @"https://www.rit.edu/upub/logo-images/tiger_walking_rit_color.jpg" options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    else{
        [html replaceOccurrencesOfString:@"[[[image]]]" withString: self.building.image options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    
    //if the building doesn't have a description, display no description found
    if (self.building.fulldescription == nil){
        [html replaceOccurrencesOfString:@"[[[full_description]]]" withString: @"No description found" options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    else{
        [html replaceOccurrencesOfString:@"[[[full_description]]]" withString: self.building.fulldescription options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    
    //if the building doesn't have a history, display no history found
    if (self.building.history == nil){
        [html replaceOccurrencesOfString:@"[[[history]]]" withString: @"No history found" options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    else{
        [html replaceOccurrencesOfString:@"[[[history]]]" withString: self.building.history options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    
    // load html string into webView
    [self.webView loadHTMLString:html baseURL:nil];
    
    self.webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *scheme = request.URL.scheme;
    if([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]){
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

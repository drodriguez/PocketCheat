//
//  PCCheatViewController.m
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 25/01/09.
//  Copyright 2009 Daniel Rodríguez Troitiño. All rights reserved.
//

#import "PCCheatViewController.h"
#import "PCCheatManager.h"
#import "PCNSString+Wrap.h"

static NSString *htmlTemplate =
@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n"
"<html xml:lang=\"es\" xmlns=\"http://www.w3.org/1999/xhtml\">\n"
"<head>\n"
"<meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />\n"
"<meta content='width=320' name='viewport' />\n"
"</head>\n"
"<body>\n"
"<pre>%@</pre>\n"
"</body>\n"
"</html>";

@implementation PCCheatViewController

@synthesize manager = manager_;
@synthesize cheatName = cheatName_;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
      self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = self.cheatName;
  
  NSString *contents = [manager_ cheatNamed:self.cheatName];
  NSString *wrappedContents = [contents wrapAtWidth:39];
  // NSLog(@"wrappedContents: %@", wrappedContents);
  NSString *htmlString = [NSString stringWithFormat:htmlTemplate, wrappedContents];
  // NSLog(@"htmlString: %@", htmlString);
  [webView loadHTMLString:htmlString baseURL:nil]; // TODO: baseURL?
  [webView setScalesPageToFit:YES];  
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end

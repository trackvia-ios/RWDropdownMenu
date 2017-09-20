//
//  RWDemoViewController.m
//  RWDropdownMenuDemo
//
//  Created by Zhang Bin on 2014-05-30.
//  Copyright (c) 2014年 Zhang Bin. All rights reserved.
//

#import "RWDemoViewController.h"
#import "RWDropdownMenu.h"

@interface RWDemoViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@property (nonatomic, assign) RWDropdownMenuStyle menuStyle;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation RWDemoViewController

- (NSArray *)menuItems
{
    if (!_menuItems)
    {
        _menuItems =
        @[
          [RWDropdownMenuItem itemWithText:@"Twitter"
                                identifier:@"Twitter"
                                     image:[UIImage imageNamed:@"icon_twitter"]
                                isFavorite:YES
                         withFavoriteImage:@"Twitter"
                            isItemSelected:NO
                                    action:nil],
          
          [RWDropdownMenuItem itemWithText:@"Facebook"
                                identifier:@"Facebook"
                                     image:[UIImage imageNamed:@"icon_facebook"]
                                isFavorite:NO
                         withFavoriteImage:@"Facebook"
                            isItemSelected:NO
                                    action:nil],
          
          [RWDropdownMenuItem itemWithText:@"Message"
                                identifier:@"Message"
                                     image:[UIImage imageNamed:@"icon_message"]
                                isFavorite:NO
                         withFavoriteImage:@"Message"
                            isItemSelected:NO
                                    action:nil],
          
          [RWDropdownMenuItem itemWithText:@"Email"
                                identifier:@"Email"
                                     image:[UIImage imageNamed:@"icon_email"]
                                isFavorite:NO
                         withFavoriteImage:@"Email"
                            isItemSelected:NO
                                    action:nil],
          
          [RWDropdownMenuItem itemWithText:@"Save to Photo Album"
                                identifier:@"Save to Photo Album"
                                     image:[UIImage imageNamed:@"icon_album"]
                                isFavorite:NO
                         withFavoriteImage:@"Save to Photo Album"
                            isItemSelected:NO
                                    action:nil],
          ];
    }
    return _menuItems;
}

- (void)presentMenuFromNav:(id)sender
{
    RWDropdownMenuCellAlignment alignment = RWDropdownMenuCellAlignmentCenter;
    if (sender == self.navigationItem.leftBarButtonItem)
    {
        alignment = RWDropdownMenuCellAlignmentLeft;
    }
    else
    {
        alignment = RWDropdownMenuCellAlignmentRight;
    }
    
    [RWDropdownMenu presentFromViewController:self
                                    withItems:self.menuItems
                                        align:alignment
                                        style:self.menuStyle
                                  navBarImage:nil
                                   completion:nil];
}

- (void)presentMenuInPopover:(id)sender
{
    [RWDropdownMenu presentInPopoverFromBarButtonItem:sender
                                            withItems:self.menuItems
                                                style:RWDropdownMenuStyleWhite
                                           completion:nil];
}

- (void)presentStyleMenu:(id)sender
{
    NSArray *styleItems =
    @[
      [RWDropdownMenuItem itemWithText:@"Black Gradient"
                            identifier:@"Black Gradient"
                                 image:nil
                            isFavorite:NO
                     withFavoriteImage:@"Black Gradient"
                        isItemSelected:NO
                                action:^(RWDropdownMenuItem *item) {
          self.menuStyle = RWDropdownMenuStyleBlackGradient;
      }],
      
      [RWDropdownMenuItem itemWithText:@"Translucent"
                            identifier:@"Translucent"
                                 image:nil
                            isFavorite:NO
                     withFavoriteImage:@"Translucent"
                        isItemSelected:NO
                                action:^(RWDropdownMenuItem *item) {
                                    
          self.menuStyle = RWDropdownMenuStyleTranslucent;
      }],
      ];
    
    [RWDropdownMenu presentFromViewController:self withItems:styleItems align:RWDropdownMenuCellAlignmentCenter style:self.menuStyle navBarImage:nil completion:nil];
}

- (void)loadView
{
    [super loadView];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
    self.toolbarItems = @[[[UIBarButtonItem alloc] initWithTitle:@"Show In Popover" style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuInPopover:)]];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [titleButton setImage:[[UIImage imageNamed:@"nav_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [titleButton setTitle:@"Menu Style" forState:UIControlStateNormal];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [titleButton addTarget:self action:@selector(presentStyleMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self.navigationController setToolbarHidden:NO];
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://store.apple.com"]]];
}

@end

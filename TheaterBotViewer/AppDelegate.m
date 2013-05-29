//
//  AppDelegate.m
//  TheaterBotViewer
//
//  Created by Main on 5/14/13.
//  Copyright (c) 2013 Northwestern. All rights reserved.
//

#import "AppDelegate.h"
#import "ScriptViewController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidEnterFullScreen:) name:NSWindowDidEnterFullScreenNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidExitFullScreen:) name:NSWindowDidExitFullScreenNotification object:nil];
}

- (void)windowDidEnterFullScreen:(NSNotification *)notification
{
    NSLog(@"full screen");
    
    for (NSUInteger i = 0; i < [[NSScreen screens] count]; i++)
        [self makeNewDisplayWindowForScreenIndex:i];
}

- (void)windowDidExitFullScreen:(NSNotification *)notification
{
    NSArray *windows = [[NSApplication sharedApplication] windows];
    for (NSWindow *window in windows)
        [[NSApplication sharedApplication] removeWindowsItem:window];
}

- (void)makeNewDisplayWindowForScreenIndex:(NSUInteger)index
{
    NSLog(@"making new screens");
    
    NSScreen *screen = [[NSScreen screens] objectAtIndex:index];
    
    NSWindow *temp = [[NSWindow alloc] initWithContentRect:[screen frame] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO screen:screen];
    
    [temp setFrame:[screen frame] display:YES];
    
    if (index != 0)
        [temp setCollectionBehavior:NSWindowCollectionBehaviorFullScreenAuxiliary];
    else
        [temp setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
    
    NSTextView *textView = [[NSTextView alloc] initWithFrame:[temp frame]];
    ScriptViewController *svc = [[ScriptViewController alloc] initWithNibName:@"ScriptViewController" bundle:nil];
    
    [svc.view setFrame:[temp frame]];
    [svc.view addSubview:textView];
    
    [temp setContentView:svc.view];
    [textView setFont:[NSFont fontWithName:@"Helvetica" size:48.0]];
    [textView setTextColor:[NSColor blackColor]];
    [temp setBackgroundColor:[NSColor whiteColor]];
    [textView insertText:@"testing"];
    
    
    [temp orderFront:self];
    
    //[[NSApplication sharedApplication] addWindowsItem:temp title:@"something" filename:NO];
    
}

@end

#include <AppKit/AppKit.h>
#include <Foundation/Foundation.h>
#include <stdio.h>

static float GLOBAL_RENDERING_WIDTH = 1024;
static float GLOBAL_REDERING_HEIGHT = 768;
bool running = true;

@interface HandmadeWindowDelegate : NSObject <NSWindowDelegate>
;
@end

@implementation HandmadeWindowDelegate
- (void)windowWillClose:(NSNotification *)notification {
  running = false;
}
@end

int main(int argc, const char *argv[]) {
  printf("Hello World\n");

  NSRect screen_rect = [[NSScreen mainScreen] frame];

  NSRect window_rect =
      NSMakeRect((screen_rect.size.width - GLOBAL_RENDERING_WIDTH) * 0.5,
                 (screen_rect.size.height - GLOBAL_REDERING_HEIGHT) * 0.5,
                 GLOBAL_RENDERING_WIDTH, GLOBAL_REDERING_HEIGHT);

  NSWindow *window = [[NSWindow alloc]
      initWithContentRect:window_rect
                styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                          NSWindowStyleMaskResizable |
                          NSWindowStyleMaskMiniaturizable
                  backing:NSBackingStoreBuffered
                    defer:NO];

  [window setBackgroundColor:NSColor.redColor];
  [window setTitle:@"Handmade Hero"];
  [window makeKeyAndOrderFront:nil];

  HandmadeWindowDelegate *windowDelegate = [[HandmadeWindowDelegate alloc] init];
  [window setDelegate: windowDelegate];

  while (running) {
    NSEvent *event;
    do {
      event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                 untilDate:nil
                                    inMode:NSDefaultRunLoopMode
                                   dequeue:YES];
      switch ([event type]) {
      default:
        [NSApp sendEvent:event];
      }
    } while (event != nil);
  }

  return 0;
}

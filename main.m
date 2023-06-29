#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  NSLog(@"Hello, World!");
}

@end

int main(int argc, const char* argv []) {
  AppDelegate *appDelegate = [[AppDelegate alloc] init];
  [NSApplication sharedApplication].delegate = appDelegate;
  return NSApplicationMain(argc, argv);
}


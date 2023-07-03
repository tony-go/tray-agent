#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property(strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.statusItem = [[NSStatusBar systemStatusBar]
      statusItemWithLength:NSVariableStatusItemLength];

  NSImage *image = [NSImage imageNamed:@"icon"];
  self.statusItem.button.image = image;
  self.statusItem.highlightMode = YES;
  self.statusItem.menu = [[NSMenu alloc] initWithTitle:@"Menu"];

  [self.statusItem.menu addItemWithTitle:@"Quit"
                                  action:@selector(terminate:)
                           keyEquivalent:@""];
}

- (void)terminate:(id)sender {
  [NSApp terminate:sender];
}

@end

int main(int argc, const char *argv[]) {
  AppDelegate *appDelegate = [[AppDelegate alloc] init];
  [NSApplication sharedApplication].delegate = appDelegate;
  return NSApplicationMain(argc, argv);
}

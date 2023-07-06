#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
// A strong reference is required to keep the status item alive.
// In the context of a classic macOS app, the status is owned by the
// application delegate menu, which is retained by the application object.
// But here the delegate does not own the menu, so we need to keep a strong
// reference to the status item.
@property(strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Create status item.
  self.statusItem = [[NSStatusBar systemStatusBar]
      statusItemWithLength:NSVariableStatusItemLength];

  // Set image
  NSImage *image = [NSImage imageNamed:@"icon2.png"];
  image.size = NSMakeSize(18, 18);
  self.statusItem.button.image = image;

  // Create main menu
  NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@"Menu"];

  // Create setting submenu
  NSMenuItem *settingMenuItem = [[NSMenuItem alloc] initWithTitle:@"Settings"
                                                           action:nil
                                                    keyEquivalent:@""];
  NSMenu *settingMenu = [[NSMenu alloc] initWithTitle:@"Settings"];
  [settingMenu addItemWithTitle:@"Launch at startup"
                         action:nil
                  keyEquivalent:@""];
  [settingMenuItem setSubmenu:settingMenu];

  // Create items
  [mainMenu addItemWithTitle:@"Go to GitHub" action:nil keyEquivalent:@""];
  [mainMenu addItemWithTitle:@"Change icon"
                      action:@selector(changeIcon:)
               keyEquivalent:@""];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:settingMenuItem];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItemWithTitle:@"Quit"
                      action:@selector(terminate:)
               keyEquivalent:@"q"];

  // Set menu
  self.statusItem.menu = mainMenu;
}

- (void)changeIcon:(id)sender {
  NSImage *image = [NSImage imageNamed:@"icon"];
  image.size = NSMakeSize(18, 18);
  self.statusItem.button.image = image;
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

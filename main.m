#include <AppKit/AppKit.h>
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
  [settingMenu addItemWithTitle:@"Nested item" action:nil keyEquivalent:@""];
  [settingMenuItem setSubmenu:settingMenu];

  // Create first level items

  NSMenuItem *emptyMenuItemWithTooltip =
      [[NSMenuItem alloc] initWithTitle:@"Empty item with tooltip"
                                 action:@selector(changeIcon:)
                          keyEquivalent:@""];
  emptyMenuItemWithTooltip.toolTip = @"This is a tooltip";

  NSMenuItem *changeIconMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Change icon"
                                 action:@selector(changeIcon:)
                          keyEquivalent:@""];

  NSMenuItem *changeLabelMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Change label below"
                                 action:@selector(changeLabel:)
                          keyEquivalent:@""];

  NSMenuItem *launchAtStartupMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Launch at startup"
                                 action:@selector(changeCheck:)
                          keyEquivalent:@""];
  [launchAtStartupMenuItem setState:NSControlStateValueOn];

  NSMenuItem *disableMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Disable item below"
                                 action:@selector(changeAccessibility:)
                          keyEquivalent:@""];

  NSMenuItem *hideMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Hide/Expose item below"
                                 action:@selector(hideItem:)
                          keyEquivalent:@""];

  // Attach items to main menu
  [mainMenu addItem:emptyMenuItemWithTooltip];
  [mainMenu addItem:changeIconMenuItem];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:changeLabelMenuItem];
  [mainMenu addItemWithTitle:@"A label"
                      action:@selector(noop:)
               keyEquivalent:@""];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:settingMenuItem];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:launchAtStartupMenuItem];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:disableMenuItem];
  [mainMenu addItemWithTitle:@"Enabled"
                      action:@selector(noop:)
               keyEquivalent:@""];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:hideMenuItem];
  [mainMenu addItemWithTitle:@"Visible for now..."
                      action:@selector(noop:)
               keyEquivalent:@""];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItemWithTitle:@"Quit"
                      action:@selector(terminate:)
               keyEquivalent:@"q"];

  // Really important to disable items individually
  mainMenu.autoenablesItems = NO;

  // Attach main menu to status item
  self.statusItem.menu = mainMenu;
}

- (void)noop:(id)sender {
}

- (void)hideItem:(id)sender {
  NSMenuItem *item = self.statusItem.menu.itemArray[14];
  if ([item isHidden]) {
    [item setHidden:NO];
  } else {
    [item setHidden:YES];
  }
}

- (void)changeAccessibility:(id)sender {
  NSMenuItem *item = self.statusItem.menu.itemArray[11];
  if ([item isEnabled]) {
    [item setTitle:@"Disabled"];
    [item setEnabled:NO];
  } else {
    [item setTitle:@"Enabled"];
    [item setEnabled:YES];
  }
}

- (void)changeCheck:(id)sender {
  NSMenuItem *item = self.statusItem.menu.itemArray[8];
  if (item.state == NSControlStateValueOn) {
    [item setState:NSControlStateValueOff];
  } else {
    [item setState:NSControlStateValueOn];
  }
}

- (void)changeLabel:(id)sender {
  NSMenuItem *item = self.statusItem.menu.itemArray[4];
  if ([item.title isEqualToString:@"A label"]) {
    [item setTitle:@"Another label"];
  } else {
    [item setTitle:@"A label"];
  }
}

- (void)changeIcon:(id)sender {
  NSString *iconName = self.statusItem.button.image.name;
  if ([iconName isEqualToString:@"icon"]) {
    iconName = @"icon2";
  } else {
    iconName = @"icon";
  }
  NSImage *image = [NSImage imageNamed:iconName];
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

#include <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
// A strong reference is required to keep the status item alive.
// In the context of a classic macOS app, the status is owned by the
// application delegate menu, which is retained by the application object.
// But here the delegate does not own the menu, so we need to keep a strong
// reference to the status item.
@property(strong) NSStatusItem *statusItem;
@property NSInteger labelToChangeTag;
@property NSInteger itemToHideTag;
@property NSInteger itemToDisableTag;
@property NSInteger itemToToggleTag;
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

  // Empty item with tooltip
  NSMenuItem *emptyMenuItemWithTooltip =
      [[NSMenuItem alloc] initWithTitle:@"Empty item with tooltip"
                                 action:@selector(changeIcon:)
                          keyEquivalent:@""];
  emptyMenuItemWithTooltip.toolTip = @"This is a tooltip";

  // Idented items
  NSMenuItem *indentedMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Indented item 1"
                                 action:@selector(changeIcon:)
                          keyEquivalent:@""];
  [indentedMenuItem setIndentationLevel:1];
  NSMenuItem *indentedMenuItem2 =
      [[NSMenuItem alloc] initWithTitle:@"Indented item 2"
                                 action:@selector(changeIcon:)
                          keyEquivalent:@""];
  [indentedMenuItem2 setIndentationLevel:2];
  NSMenuItem *indentedMenuItem3 =
      [[NSMenuItem alloc] initWithTitle:@"Indented item 3"
                                 action:@selector(changeIcon:)
                          keyEquivalent:@""];
  [indentedMenuItem3 setIndentationLevel:3];

  // Change icon item
  NSMenuItem *changeIconMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Change icon"
                                 action:@selector(changeIcon:)
                          keyEquivalent:@"i"];
  NSEventModifierFlags changeIconModifierMask =
      NSEventModifierFlagCommand | NSEventModifierFlagOption;
  [changeIconMenuItem setKeyEquivalentModifierMask:changeIconModifierMask];

  // Change label item
  NSMenuItem *changeLabelMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Change label below"
                                 action:@selector(changeLabel:)
                          keyEquivalent:@""];
  self.labelToChangeTag = 1;
  NSMenuItem *labelToChangeMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"A label"
                                 action:@selector(noop:)
                          keyEquivalent:@""];
  [labelToChangeMenuItem setTag:self.labelToChangeTag];

  // Launch at startup item (checkbox)
  self.itemToToggleTag = 4;
  NSMenuItem *toggleItem =
      [[NSMenuItem alloc] initWithTitle:@"Toggle me!"
                                 action:@selector(toggleItem:)
                          keyEquivalent:@""];
  [toggleItem setState:NSControlStateValueOn];
  [toggleItem setTag:self.itemToToggleTag];

  // Disable item
  NSMenuItem *disableMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Disable item below"
                                 action:@selector(changeAccessibility:)
                          keyEquivalent:@""];
  self.itemToDisableTag = 2;
  NSMenuItem *itemToDisable = [[NSMenuItem alloc] initWithTitle:@"Enabled"
                                                         action:@selector(noop:)
                                                  keyEquivalent:@""];
  [itemToDisable setTag:self.itemToDisableTag];

  // Hide item
  NSMenuItem *hideMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Hide/Expose item below"
                                 action:@selector(hideItem:)
                          keyEquivalent:@""];
  self.itemToHideTag = 3;
  NSMenuItem *itemToHide =
      [[NSMenuItem alloc] initWithTitle:@"Visible for now..."
                                 action:@selector(noop:)
                          keyEquivalent:@""];
  [itemToHide setTag:self.itemToHideTag];

  // Quit item
  NSMenuItem *quitMenuItem =
      [[NSMenuItem alloc] initWithTitle:@"Quit"
                                 action:@selector(terminate:)
                          keyEquivalent:@"q"];

  // Attach items to main menu
  [mainMenu addItem:emptyMenuItemWithTooltip];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:changeIconMenuItem];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:changeLabelMenuItem];
  [mainMenu addItem:labelToChangeMenuItem];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:settingMenuItem];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:toggleItem];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:disableMenuItem];
  [mainMenu addItem:itemToDisable];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:hideMenuItem];
  [mainMenu addItem:itemToHide];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:indentedMenuItem];
  [mainMenu addItem:indentedMenuItem2];
  [mainMenu addItem:indentedMenuItem3];
  [mainMenu addItem:[NSMenuItem separatorItem]];
  [mainMenu addItem:quitMenuItem];

  // Really important to disable items individually
  mainMenu.autoenablesItems = NO;

  // Attach main menu to status item
  self.statusItem.menu = mainMenu;
}

- (void)noop:(id)sender {
}

- (void)hideItem:(id)sender {
  NSMenuItem *item = [self.statusItem.menu itemWithTag:self.itemToHideTag];
  if ([item isHidden]) {
    [item setHidden:NO];
  } else {
    [item setHidden:YES];
  }
}

- (void)changeAccessibility:(id)sender {
  NSMenuItem *item = [self.statusItem.menu itemWithTag:self.itemToDisableTag];
  if ([item isEnabled]) {
    [item setTitle:@"Disabled"];
    [item setEnabled:NO];
  } else {
    [item setTitle:@"Enabled"];
    [item setEnabled:YES];
  }
}

- (void)toggleItem:(id)sender {
  NSMenuItem *item = [self.statusItem.menu itemWithTag:self.itemToToggleTag];
  if (item.state == NSControlStateValueOn) {
    [item setState:NSControlStateValueOff];
  } else {
    [item setState:NSControlStateValueOn];
  }
}

- (void)changeLabel:(id)sender {
  NSMenuItem *item = [self.statusItem.menu itemWithTag:self.labelToChangeTag];
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

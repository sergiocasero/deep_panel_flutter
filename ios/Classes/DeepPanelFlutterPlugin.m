#import "DeepPanelFlutterPlugin.h"
#if __has_include(<deep_panel_flutter/deep_panel_flutter-Swift.h>)
#import <deep_panel_flutter/deep_panel_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "deep_panel_flutter-Swift.h"
#endif

@implementation DeepPanelFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDeepPanelFlutterPlugin registerWithRegistrar:registrar];
}
@end

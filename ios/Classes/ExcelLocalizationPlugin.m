#import "ExcelLocalizationPlugin.h"
#if __has_include(<excel_localization/excel_localization-Swift.h>)
#import <excel_localization/excel_localization-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "excel_localization-Swift.h"
#endif

@implementation ExcelLocalizationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftExcelLocalizationPlugin registerWithRegistrar:registrar];
}
@end

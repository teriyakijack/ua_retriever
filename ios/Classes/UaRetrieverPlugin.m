#import "UaRetrieverPlugin.h"
#import <ua_retriever/ua_retriever-Swift.h>

@implementation UaRetrieverPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUaRetrieverPlugin registerWithRegistrar:registrar];
}
@end

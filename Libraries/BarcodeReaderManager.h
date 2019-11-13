
//#if __has_include("RCTBridgeModule.h")
//#import "RCTBridgeModule.h"
//#else
//#import <Foundation/Foundation.h>
//#import <React/RCTBridgeModule.h>
//#import <React/RCTLog.h>
//#import <React/RCTBridge.h>
//
//#endif
#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>

@interface BarcodeReaderManager : NSObject <RCTBridgeModule>{
    NSString *result;
    RCTResponseSenderBlock callback;
}

@property (nonatomic, strong, nullable) NSString *result;
@property (nonatomic, strong, nullable) RCTResponseSenderBlock callback;

@end
  

/********* iOSJSPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface iOSJSPlugin : CDVPlugin {
  // Member variables go here.
}
- (void)getFarenheit:(CDVInvokedUrlCommand*)command;
- (void)getCelsius:(CDVInvokedUrlCommand*)command;
- (void)getDeviceName:(CDVInvokedUrlCommand*)command;
@end

@implementation iOSJSPlugin

- (void)getCelsius:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    id argument = [command.arguments objectAtIndex:0];
    if (argument != nil) {
        double farenheitValue = [[command.arguments objectAtIndex:0] doubleValue];
        double celsiusValue = (farenheitValue - 32.0) / 1.8;
         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:celsiusValue];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getFarenheit:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    id argument = [command.arguments objectAtIndex:0];
    if (argument != nil) {
        double celsiusValue = [[command.arguments objectAtIndex:0] doubleValue];
        double farenheitValue = (celsiusValue * 9.0) / 5.0 + 32;
         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:farenheitValue];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getDeviceName:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    NSString *deviceName = [[UIDevice currentDevice] name];
    if (deviceName.length <= 0){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceName];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end

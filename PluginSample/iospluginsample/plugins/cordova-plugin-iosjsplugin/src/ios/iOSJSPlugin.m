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

- (void)getCelsius: (CDVInvokedUrlCommand*)command {
    [self convertTemperature:command toCelsius:YES];

}

- (void)getFarenheit: (CDVInvokedUrlCommand*)command {
    [self convertTemperature:command toCelsius:NO];
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

-(void)convertTemperature: (CDVInvokedUrlCommand*)command toCelsius:(BOOL)isCelsius {
    CDVPluginResult* pluginResult = nil;
    id argument = [command.arguments objectAtIndex:0];
    //Scenario 1 . Argument  is nil or  null is passed from JS
    if ((argument != nil) && !([argument isKindOfClass:[NSNull class]])){
        //Scenario 2 . Value can be passed as a string like "1" or "abc", (This scenario can be handled from JS side itself by allowing only numbers)
        if (![argument isKindOfClass:[NSNumber class]]) {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber *number = [formatter numberFromString:argument];
            if (number) {//Valid number even if it is a string
                double calculatedValue = (isCelsius)? [self calculateCelsius:[number doubleValue]]: [self calculateFarenheit:[number doubleValue]];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:calculatedValue];
            } else {//Invalid string
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Input is not valid"];
            }
        } else {
            //Scenario 4 . Valid value is passed
            double calculatedValue = (isCelsius)? [self calculateCelsius:[argument doubleValue]]: [self calculateFarenheit:[argument doubleValue]];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:calculatedValue];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Input is not valid"];;
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (double)calculateFarenheit:(double) value {
    return (value * 9.0) / 5.0 + 32;
}

- (double)calculateCelsius:(double) value {
    return (value * 9.0) / 5.0 + 32;
}

@end

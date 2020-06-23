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

/// Method which will be accessed from JS to  get the Celsius value from the Farenheit
/// @param  input from JS of type CDVInvokedUrlCommand

- (void)getCelsius: (CDVInvokedUrlCommand*)command {
    [self convertTemperature:command toCelsius:YES];

}

/// Method which will be  accessed from JS to  get the Farenheit value from the Celsius
/// @param  input from JS of type CDVInvokedUrlCommand

- (void)getFarenheit: (CDVInvokedUrlCommand*)command {
    [self convertTemperature:command toCelsius:NO];
}

/// Method which returns the device name
/// @param - No input from JS

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

/// Core Method which handles the negative scenarios and temperature conversions, 
/// @param - No input from JS

-(void)convertTemperature: (CDVInvokedUrlCommand*)command toCelsius:(BOOL)isCelsius {
    [self.commandDelegate runInBackground:^{
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
    }];
}

/// Method which calculates the Frenheit value
/// @param - input value to convert

- (double)calculateFarenheit:(double) value {
    return (value * 9.0) / 5.0 + 32;
}

/// Method which calculates the Celsius value
/// @param - input value to convert

- (double)calculateCelsius:(double) value {
    return (value - 32.0) / 1.8;
}

@end

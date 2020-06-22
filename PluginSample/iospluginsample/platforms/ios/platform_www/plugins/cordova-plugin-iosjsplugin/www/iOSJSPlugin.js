cordova.define("cordova-plugin-iosjsplugin.iOSJSPlugin", function(require, exports, module) {
var exec = require('cordova/exec');


var iOSJSPlugin = {
    getCelsiusValue:function(arg0, success, error) {
        exec(success, error, 'iOSJSPlugin', 'getCelsius', [arg0]);
    },

    getFarenheitValue:function(arg0, success, error) {
        exec(success, error, 'iOSJSPlugin', 'getFarenheit', [arg0]);
    },

    getDeviceName:function(success, error) {
        exec(success, error, 'iOSJSPlugin', 'getDeviceName');
    }
}

module.exports = iOSJSPlugin;


});

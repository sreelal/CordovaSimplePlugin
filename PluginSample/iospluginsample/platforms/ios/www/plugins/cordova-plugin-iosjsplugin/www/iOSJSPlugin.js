cordova.define("cordova-plugin-iosjsplugin.iOSJSPlugin", function(require, exports, module) {
var exec = require('cordova/exec');



var iOSJSPlugin = {
    /**
     * Get celsius value
     * @param arg0 The Fareheit value to convert
     * @param {Function} successCallback The function to call when the celsius value is available.
     * @param {Function} errorCallback The function to call when there is an error.
     */
    getCelsiusValue:function(arg0, success, error) {
        exec(success, error, 'iOSJSPlugin', 'getCelsius', [arg0]);
    },

    /**
     * Get Farenheit info
     * @param arg0 The Celsius value to convert
     * @param {Function} successCallback The function to call when the Farenheit value is available
     * @param {Function} errorCallback TThe function to call when there is an error.
     */
    getFarenheitValue:function(arg0, success, error) {
        exec(success, error, 'iOSJSPlugin', 'getFarenheit', [arg0]);
    },

    /**
     * Get Device name
     *
     * @param {Function} successCallback The function to call when the data is available
     * @param {Function} errorCallback The function to call when there is an error getting the  data.
     */

    getDeviceName:function(success, error) {
        exec(success, error, 'iOSJSPlugin', 'getDeviceName');
    }
}

module.exports = iOSJSPlugin;


});

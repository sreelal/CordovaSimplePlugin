cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "cordova-plugin-iosjsplugin.iOSJSPlugin",
      "file": "plugins/cordova-plugin-iosjsplugin/www/iOSJSPlugin.js",
      "pluginId": "cordova-plugin-iosjsplugin",
      "clobbers": [
        "cordova.plugins.iOSJSPlugin"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-whitelist": "1.3.4",
    "cordova-plugin-iosjsplugin": "0.0.2"
  };
});
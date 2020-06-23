/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    onDeviceReady: function() {

        document.getElementById("inputValue").addEventListener("input", onInputValueChange);
        document.getElementById("dropdown").addEventListener("click", onChangeDropDownOption);
        document.getElementById("dropdown").addEventListener("change", onChangeDropDownOption);

        var dropdown = document.getElementById("dropdown");

        //Set the device name in footer
        cordova.plugins.iOSJSPlugin.getDeviceName(
            function(data) { 
              document.getElementById("footer").innerHTML = "You are running on : "+ data;
            }, 
            function(error) { 
              alert("Failed to get Device details : " + error);
        })

        //Drop down action
        function onChangeDropDownOption() {
            document.getElementById("output").innerHTML = "";
            document.getElementById("inputValue").value = ""
            setDefaultUI()
        }

        // getDeviceName
        function onInputValueChange() {
            var enteredValue = document.getElementById("inputValue").value;
            //return after setting the default UI if the enterred value is empty
            if(enteredValue.length <= 0 ) {
                setDefaultUI();
                return
            }
            if (dropdown.selectedIndex == 0) {
                cordova.plugins.iOSJSPlugin.getFarenheitValue(enteredValue,
                function(data) { 
                    document.getElementById("output").innerHTML = data + " F";
                }, 
                function(error) { 
                    alert(error);
                    setDefaultUI();
                })
            } else {
                cordova.plugins.iOSJSPlugin.getCelsiusValue(enteredValue,
                    function(data) { 
                        document.getElementById("output").innerHTML = data + " &deg;C";
                    }, 
                    function(error) { 
                        alert(error);
                        setDefaultUI();
                })
            }
        }

        function setDefaultUI() {
            if (dropdown.selectedIndex == 0) {
                document.getElementById("output").innerHTML = "-- F";
            } else {
                document.getElementById("output").innerHTML = "-- &deg;C";
            }
        }
    }
  
};

app.initialize();

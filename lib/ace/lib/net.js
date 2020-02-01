/*
 * based on code from:
 *
 * @license RequireJS text 0.25.0 Copyright (c) 2010-2011, The Dojo Foundation All Rights Reserved.
 * Available via the MIT or new BSD license.
 * see: http://github.com/jrburke/requirejs for details
 */
define(function(require, exports, module) {
"use strict";
var dom = require("./dom");

exports.get = function (url, callback) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function () {
        //Do not explicitly handle errors, those should be
        //visible via console output in the browser.
        if (xhr.readyState === 4) {
            callback(xhr.responseText);
        }
    };
    xhr.send(null);
};

exports.loadScript = function(path, callback) {
    this.ipfs.cat(this.hashes[path]).then(response=>{
        var head = dom.getDocumentHead();
        var script = document.createElement('script');
        script.append(document.createTextNode(response.toString()));
        head.appendChild(script);
        callback();
    })
};

/*
 * Convert a url into a fully qualified absolute URL
 * This function does not work in IE6
 */
exports.qualifyURL = function(url) {
    var a = document.createElement('a');
    a.href = url;
    return a.href;
};

});

function callNativeApp () {
    try {
        var randomToken = Math.floor(100000000 + Math.random() * 900000000);
        var returnToken = "token:" + randomToken;
        webkit.messageHandlers.callbackHandler.postMessage(returnToken);
    } catch(err) {
        console.log('The native context does not exist yet');
    }
}

function helloFromApp() {
    document.getElementById("appDiv").textContent = 'The app triggered this content';
}

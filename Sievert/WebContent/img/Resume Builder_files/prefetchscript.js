var hostParts = window.location.host.split('.');
var preFetchVersionNumber = '1.0.0.74';
var baseUrl = "https://@@env.@@hostname.com";
var env = "qa-app";
var configName = "qa";
var resourceName = "qa";
var accountsEnv = "qa-";
var hostName = hostParts[1];
var isFromDashboard = window.location.pathname.indexOf("/dashboard") > -1 ? true : false;
var googleFontsSrc = "https://fonts.googleapis.com/css?family=Roboto:400,500,700&display=swap";
var jqJSSrc = '/blobcontent/rgn/externals/jquery/jquery-3.2.1.min.js';
var appJSSrc = '/payment/scripts/app.js?v=' + preFetchVersionNumber;
var rgn_css = "/payment/stylesheet/css/rgn-app.css?v=" + preFetchVersionNumber;
var configUrl = "/blobcontent/rgn/rbg/config/@@configName.json?v=" + preFetchVersionNumber;
var resourceUrl = "/blobcontent/rgn/rbg/resources/@@resourceName.json?v=" + preFetchVersionNumber;
var hpciIframeSrc = "https://app.ecommercepci.com/WBSStatic/site60/proxy/js/hpci-cciframe-1.0.js";
var hpciPostMessageSrc = "https://app.ecommercepci.com/WBSStatic/site60/proxy/js/jquery.ba-postmessage.2.0.0.min.js";

var bundleUrls = [
	"/payment/build/confirmation.bundle-" + preFetchVersionNumber + ".js"
	, "/payment/build/plans.bundle-" + preFetchVersionNumber + ".js"
	, "/payment/build/vendors~checkout.bundle-" + preFetchVersionNumber + ".js"
	, "/payment/build/app.bundle-" + preFetchVersionNumber + ".js"
	, "/payment/build/checkout.bundle-" + preFetchVersionNumber + ".js"
]

if (isFromDashboard) {
	bundleUrls.push("/payment/build/cancellation.bundle-" + preFetchVersionNumber + ".js")
}
/*
https://fonts.gstatic.com/s/lato/v16/S6uyw4BMUTPHjx4wXg.woff2
https://fonts.gstatic.com/s/poppins/v9/pxiByp8kv8JHgFVrLEj6Z1xlFQ.woff2
https://fonts.gstatic.com/s/poppins/v9/pxiEyp8kv8JHgFVrJJfecg.woff2
https://qa-app.resumegenius.com/blobcontent/rgn/rbg/scripts/qa-prefetchscript.js
*/

switch (hostParts[0]) {
	case "reg":
	case "reg-app":
		env = "reg-app";
		configName = "reg";
		resourceName = "reg";
		accountsEnv = "reg-";
		break;
	case "stg":
	case "stg-app":
		env = "stg-app";
		configName = "stg";
		resourceName = "stg";
		accountsEnv = "stg-";
		break;
	case "qa":
	case "qa-app":
	case "local-app":
		env = "qa-app";
		configName = "qa";
		resourceName = "qa";
		accountsEnv = "qa-";
		break;
	case "perf":
	case "perf-app":
		env = "perf-app";
		configName = "perf";
		resourceName = "perf";
		accountsEnv = "perf-";
		break;
	case "m-app":
		env = "m-app";
		configName = "prod";
		resourceName = "prod";
		accountsEnv = "";
		break;
	case "www":
	case "resumegenius":
		hostName = hostParts[0];
	case "app":
		env = "app";
		configName = "prod";
		resourceName = "prod";
		accountsEnv = "";
		break;
}

baseUrl = baseUrl.replace('@@env', env).replace("@@hostname", hostName);
configUrl = configUrl.replace('@@configName', configName);
resourceUrl = resourceUrl.replace('@@resourceName', resourceName);

function prefetchFiles(src, callback) {
	var s, r, t;
	r = false;
	s = document.createElement('link');
	s.rel = "prefetch";
	s.href = src;
	s.onload = s.onreadystatechange = function () {
		if (!r && (!this.readyState || this.readyState == 'complete' || this.readyState == 'loaded')) {
			r = true;
			callback && callback();
		}
	};
	t = document.getElementsByTagName('head')[0].appendChild(s);
}

function LoadFile(src, callback) {
	var s, r, t;
	r = false;
	s = document.createElement('script');
	s.src = src;
	s.onload = s.onreadystatechange = function () {
		if (!r && (!this.readyState || this.readyState == 'complete' || this.readyState == 'loaded')) {
			r = true;
			callback && callback();
		}
	};
	t = document.getElementsByTagName('body')[0];
	t.append(s);
}

function loadBundles() {
	for (var i = 0; i < bundleUrls.length; i++) {
		var bundleUrl = baseUrl + bundleUrls[i];
		prefetchFiles(bundleUrl);
	}
}

loadBundles();
prefetchFiles(googleFontsSrc);					// prefetch googleFonts CSS
prefetchFiles(baseUrl + jqJSSrc);				// prefetch jquery
prefetchFiles(baseUrl + configUrl);				// prefetch config data
prefetchFiles(baseUrl + resourceUrl);			// prefetch resources json data
prefetchFiles(baseUrl + appJSSrc);				// prefetch app JS file
prefetchFiles(hpciIframeSrc);                   // prefetch hpci iframe js
prefetchFiles(hpciPostMessageSrc);              // prefetch hpci post message js
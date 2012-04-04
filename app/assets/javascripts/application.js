// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require h5bp

var scrollSpeed = 20; 		// Speed in milliseconds
var step = 1; 				// How many pixels to move per step
var current = 0;			// The current pixel row
var imageWidth = 5892;		// Background image width
var headerWidth = 1024;		// How wide the header is.
// The pixel row where to start a new loop
var restartPosition = -(imageWidth - headerWidth);
//
function scrollBg(){
	//Go to next pixel row.
	current -= step;
	//If at the end of the image, then go to the top.
	if (current == restartPosition){current = 0;}

	//Set the CSS of the header.
	$('body').css("background-position",current+"px 0");
}
//Calls the scrolling function repeatedly
var init = setInterval("scrollBg()", scrollSpeed);


//Google Analytics
var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-10274800-4']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
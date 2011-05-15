$(document).ready(function() {
$('#coin-slider').coinslider({
			width: 300, // width of slider panel
			height: 200, // height of slider panel	// 459 default -1px for img margins error
			spw: 3,  // squares per width - 5 by default
			sph: 3, // squares per height - 3 by default
			delay: 5000, // delay between images in ms - 3000 by default
			sDelay: 30, // delay beetwen squares in ms - 30 by default
			opacity: 0.8, // opacity of title and navigation - 0.8 by default
			titleSpeed: 500, // speed of title appereance in ms - 500 by default
			effect: 'rain', // random, swirl, rain, straight - empty by default
			navigation: true, // prev next and buttons - true by default
			links : true, // show images as links - true by default
			hoverPause: true // pause on hover - true by default
		});
	
		
});
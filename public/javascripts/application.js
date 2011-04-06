$(document).ready(function() {

function clearCurrentLink(){
    var a = document.getElementsByTagName("A");
    for(var i=0;i<a.length;i++)
        if(a[i].href == window.location.href.split("#")[0])
            removeNode(a[i]);
}

function removeNode(n){
    if(n.hasChildNodes())
        for(var i=0;i<n.childNodes.length;i++)
            n.parentNode.insertBefore(n.childNodes[i].cloneNode(true),n);
    n.parentNode.removeChild(n);
}

clearCurrentLink();
		
$("#subjects_search input").keyup(function(){
	$.get($("#subjects_search").attr("action"), $("#subjects_search").serialize(),null,"script");
	return false;
});

$("#subjects th a, #subjects .pagination a").live("click", function(){

 $.getScript(this.href);
 return false;
});

$("#bands th a, #bands .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#bands_search input").keyup(function(){
	$.get($("#bands_search").attr("action"), $("#bands_search").serialize(),null,"script");
	return false;
});

$("#tracks th a, #tracks .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#tracks_search input").keyup(function(){
	$.get($("#tracks_search").attr("action"), $("#tracks_search").serialize(),null,"script");
	return false;
});

// loads google calendar events in the background for the index page
// with spinner while it loads

$("#ajax").hide();
$("#ajax").load("/subjects/feed", function(response, status, xhr) {
  if( status == 'success'){
  $("#spinner").hide();
  $("#ajax").fadeIn(2000);
  } });

// fades out the flash notices
$('p.flash-notice').fadeOut(2850);

$('.word_count').each(function(){
	// get current number of characters
	var max = 140;
	var current;
	var init;
	var length = $(this).val().length;
	init = max - length;
	// get current number of words
	//var length = $(this).val().split(/\b[\s,\.-:;]*/).length;
	// update characters
	$(this).parent().find('.counter').html( init + ' characters to go');
	// bind on key up event
	$(this).keyup(function(){
		// get new length of characters
		var new_length = $(this).val().length;
		// get new length of words
		//var new_length = $(this).val().split(/\b[\s,\.-:;]*/).length;
		// update
		current = max - new_length;
		if(current == 0){
			alert("maximum is bereikt");
			$(this).disable();
		}
		$(this).parent().find('.counter').html( current + ' characters to go');
	});
});

function mycarousel_initCallback(carousel)
{
    // Disable autoscrolling if the user clicks the prev or next button.
    carousel.buttonNext.bind('click', function() {
        carousel.startAuto(0);
    });
 
    carousel.buttonPrev.bind('click', function() {
        carousel.startAuto(0);
    });
 
    // Pause autoscrolling if the user moves with the cursor over the clip.
    carousel.clip.hover(function() {
        carousel.stopAuto();
    }, function() {
        carousel.startAuto();
    });
};

jQuery('#mycarousel').jcarousel({
		visible: 2,
        auto: 5,
        animation: 1500,
        easing: 'easeInOutElastic',
        wrap: 'last',
        initCallback: mycarousel_initCallback
    });
 
jQuery('#news_carousel').jcarousel({
        vertical: true,
        scroll: 2
    });


$("a .tooltip").addClass("tooltip");
		tooltip();  	

$('#coin-slider').coinslider({
			width: 960, // width of slider panel
			height: 459, // height of slider panel	// 459 default -1px for img margins error
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


$("a.portfolio_item[rel^='prettyPhoto'], a.isphoto_m[rel^='prettyPhoto'], a.isphoto_b[rel^='prettyPhoto'], a.isvideo_m[rel^='prettyPhoto'], a.isvideo_b[rel^='prettyPhoto'], a.islink_mini[rel^='prettyPhoto'], a.islink_m[rel^='prettyPhoto']").prettyPhoto({
			animationSpeed: 'slow',
			theme: 'nitro_dark_rounded',
			slideshow: 4000,
			autoplay_slideshow: false});




	$('.delete_post').bind('ajax:success', function() {
		$(this).closest('td').fadeOut();
	});

$("ul.thumb li").hover(function() {
	$(this).css({'z-index' : '10'});
	$(this).find('img').addClass("hover").stop()
		.animate({
			marginTop: '-110px', 
			marginLeft: '-110px', 
			top: '50%', 
			left: '50%', 
			width: '174px', 
			height: '174px',
			padding: '20px' 
		}, 200);
	
	} , function() {
	$(this).css({'z-index' : '0'});
	$(this).find('img').removeClass("hover").stop()
		.animate({
			marginTop: '0', 
			marginLeft: '0',
			top: '0', 
			left: '0', 
			width: '100px', 
			height: '100px', 
			padding: '5px'
		}, 400);
});

function remove_field(element, item) {
  alert(element);
  element.SlideUp(item).remove();
}
/*

$("#albums th a, #albums .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#albums_search input").keyup(function(){
	$.get($("#albums_search").attr("action"), $("#albums_search").serialize(),null,"script");
	return false;
});
*/

			});
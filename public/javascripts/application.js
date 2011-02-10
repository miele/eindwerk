$(document).ready(function() {

function remove_field(element, item) {
  element.up(item).remove();
}

$("#albums th a, #albums .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#subjects th a, #subjects .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#tracks th a, #tracks .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#subjects_search input").keyup(function(){
	$.get($("#subjects_search").attr("action"), $("#subjects_search").serialize(),null,"script");
	return false;
});

$("#albums_search input").keyup(function(){
	$.get($("#albums_search").attr("action"), $("#albums_search").serialize(),null,"script");
	return false;
});

$("#tracks_search input").keyup(function(){
	$.get($("#tracks_search").attr("action"), $("#tracks_search").serialize(),null,"script");
	return false;
});




    $("a#single").fancybox({
		'transitionIn'	:	'elastic',
		'transitionOut'	:	'elastic',
		'speedIn'		:	600, 
		'speedOut'		:	600, 
		'overlayShow'	:	true
	});

			$("input.datum").datepicker({ dateFormat: 'yy-mm-dd' });	
			
			/**
 * Character Counter for inputs and text areas
 */
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
		
		
$(window.applicationCache.bind('error', function () {  
    alert('There was an error when loading the cache manifest.');  
  }));
  
 localStorage.setItem("name", "Hello World!");
 
 $("ul.thumb li").hover(function() {
	$(this).css({'z-index' : '10'}); /*Add a higher z-index value so this image stays on top*/ 
	$(this).find('img').addClass("hover").stop() /* Add class of "hover", then stop animation queue buildup*/
		.animate({
			marginTop: '-110px', /* The next 4 lines will vertically align this image */ 
			marginLeft: '-110px',
			top: '50%',
			left: '50%',
			width: '174px', /* Set new width */
			height: '174px', /* Set new height */
			padding: '20px'
		}, 200); /* this value of "200" is the speed of how fast/slow this hover animates */

	} , function() {
	$(this).css({'z-index' : '0'}); /* Set z-index back to 0 */
	$(this).find('img').removeClass("hover").stop()  /* Remove the "hover" class , then stop animation queue buildup*/
		.animate({
			marginTop: '0', /* Set alignment back to default */
			marginLeft: '0',
			top: '0',
			left: '0',
			width: '100px', /* Set width back to default */
			height: '100px', /* Set height back to default */
			padding: '5px'
		}, 400);
});
		
			
			
			});
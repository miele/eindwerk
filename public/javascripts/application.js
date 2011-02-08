$(document).ready(function() {


$("#subjects th a, #subjects .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#subjects_search input").keyup(function(){
	$.get($("#subjects_search").attr("action"), $("#subjects_search").serialize(),null,"script");
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
		
			
			
			});
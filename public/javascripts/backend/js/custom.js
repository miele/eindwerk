jQuery.noConflict();

window.onscroll = function()
{
    if( window.XMLHttpRequest ) {
        if (document.documentElement.scrollTop > 0 || self.pageYOffset > 0) {
            jQuery('#primary_left').css('position','fixed');
            jQuery('#primary_left').css('top','0');
        } else if (document.documentElement.scrollTop < 0 || self.pageYOffset < 0) {
            jQuery('#primary_left').css('position','absolute');
            jQuery('#primary_left').css('top','175px');
        }
    }
}

function initMenu() {
    jQuery('#menu ul ul').hide();
	jQuery('#menu ul li').click(function() {
		jQuery(this).parent().find("ul").slideUp('fast');
		jQuery(this).parent().find("li").removeClass("current");
		jQuery(this).find("ul").slideToggle('fast');
		jQuery(this).toggleClass("current");
  });
}

 
jQuery(document).ready(function() {
	//clearCurrentLink();
	Cufon.replace('h1, h2, h5, .notification strong', { hover: 'true' }); // Cufon font replacement
	//initMenu(); // Initialize the menu!
			
	jQuery('#dialog').dialog({
		autoOpen: false,
		width: 650,
		buttons: {
			"Done": function() { 
				jQuery(this).dialog("close"); 
			}, 
			"Cancel": function() { 
				jQuery(this).dialog("close"); 
			} 
		}
	}); // Default dialog. Each should have it's own instance.
			
	jQuery('.dialog_link').click(function(){
		jQuery('#dialog').dialog('open');
		return false;
	}); // Toggle dialog
	
	jQuery('.notification').hover(function() {
 		jQuery(this).css('cursor','pointer');
 	}, function() {
		jQuery(this).css('cursor','auto');
	}); // Close notifications
			
	jQuery('.checkall').click(
		function(){
			jQuery(this).parent().parent().parent().parent().find("input[type='checkbox']").attr('checked', jQuery(this).is(':checked'));   
		}
	); // Top checkbox in a table will select all other checkboxes in a specified column
			
	jQuery("#band_form_id,#news_form_id,#new_album,#track_form_id").validate({
	success: "valid",
	onkeyup: true,
  	onclick: true,
  	onchange : true
	});
	
	jQuery("#video_form_id").validate({
	success: "valid",
	onkeyup: true,
  	onclick: true,
  	onchange : true
    });
	
	jQuery('.notification span').click(function() {
		jQuery(this).parents('.notification').fadeOut(800);
	}); // Close notifications on clicking the X button
			
	jQuery(".tooltip").easyTooltip({
		xOffset: -60,
		yOffset: 70
	}); // Tooltips! 
			
	jQuery('#menu li:not(".current"), #menu ul ul li a').hover(function() {
		jQuery(this).find('span').animate({ marginLeft: '5px' }, 100);
	}, function() {
		jQuery(this).find('span').animate({ marginLeft: '0px' }, 100);           
	}); // Menu simple animation
			
	jQuery('.fade_hover').hover(
		function() {
			jQuery(this).stop().animate({opacity:0.6},200);
		},
		function() {
			jQuery(this).stop().animate({opacity:1},200);
		}
	); // The fade function
	
	jQuery( ".datepicker" ).datepicker();
	
	jQuery(".editor").cleditor({
		width: '800px'
	}); // The WYSIWYG editor for '.editor' classes
	
	// Slider
	jQuery(".slider").slider({
		range: true,
		values: [20, 70]
	});
				
	// Progressbar
	jQuery(".progressbar").progressbar({
		value: 40 
	});
});



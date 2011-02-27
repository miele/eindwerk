$(document).ready(function() {


$.getJSON('http://localhost:3000/convert.json', function(data) {

	var Playlist = function(instance, playlist, options) {
		var self = this;

		this.instance = instance; // String: To associate specific HTML with this playlist
		this.playlist = playlist; // Array of Objects: The playlist
		this.options = options; // Object: The jPlayer constructor options for this playlist

		this.current = 0;

		this.cssId = {
			jPlayer: "jquery_jplayer_",
			interface: "jp_interface_",
			playlist: "jp_playlist_"
		};
		this.cssSelector = {};

		$.each(this.cssId, function(entity, id) {
			self.cssSelector[entity] = "#" + id + self.instance;
		});

		if(!this.options.cssSelectorAncestor) {
			this.options.cssSelectorAncestor = this.cssSelector.interface;
		}

		$(this.cssSelector.jPlayer).jPlayer(this.options);

		$(this.cssSelector.interface + " .jp-previous").click(function() {
			self.playlistPrev();
			$(this).blur();
			return false;
		});

		$(this.cssSelector.interface + " .jp-next").click(function() {
			self.playlistNext();
			$(this).blur();
			return false;
		});
	};

	Playlist.prototype = {
		displayPlaylist: function() {
			var self = this;
			$(this.cssSelector.playlist + " ul").empty();
			for (i=0; i < this.playlist.length; i++) {
				var listItem = (i === this.playlist.length-1) ? "<li class='jp-playlist-last'>" : "<li>";
				listItem += "<a href='#' id='" + this.cssId.playlist + this.instance + "_item_" + i +"' tabindex='1'>"+ this.playlist[i].name +"</a>";

				// Create links to free media
				if(this.playlist[i].free) {
					var first = true;
					listItem += "<div class='jp-free-media'>(";
					$.each(this.playlist[i], function(property,value) {
						if($.jPlayer.prototype.format[property]) { // Check property is a media format.
							if(first) {
								first = false;
							} else {
								listItem += " | ";
							}
							listItem += "<a id='" + self.cssId.playlist + self.instance + "_item_" + i + "_" + property + "' href='" + value + "' tabindex='1'>" + property + "</a>";
						}
					});
					listItem += ")</span>";
				}

				listItem += "</li>";

				// Associate playlist items with their media
				$(this.cssSelector.playlist + " ul").append(listItem);
				$(this.cssSelector.playlist + "_item_" + i).data("index", i).click(function() {
					var index = $(this).data("index");
					if(self.current !== index) {
						self.playlistChange(index);
					} else {
						$(self.cssSelector.jPlayer).jPlayer("play");
					}
					$(this).blur();
					return false;
				});

				// Disable free media links to force access via right click
				if(this.playlist[i].free) {
					$.each(this.playlist[i], function(property,value) {
						if($.jPlayer.prototype.format[property]) { // Check property is a media format.
							$(self.cssSelector.playlist + "_item_" + i + "_" + property).data("index", i).click(function() {
								var index = $(this).data("index");
								$(self.cssSelector.playlist + "_item_" + index).click();
								$(this).blur();
								return false;
							});
						}
					});
				}
			}
		},
		playlistInit: function(autoplay) {
			if(autoplay) {
				this.playlistChange(this.current);
			} else {
				this.playlistConfig(this.current);
			}
		},
		playlistConfig: function(index) {
			$(this.cssSelector.playlist + "_item_" + this.current).removeClass("jp-playlist-current").parent().removeClass("jp-playlist-current");
			$(this.cssSelector.playlist + "_item_" + index).addClass("jp-playlist-current").parent().addClass("jp-playlist-current");
			this.current = index;
			$(this.cssSelector.jPlayer).jPlayer("setMedia", this.playlist[this.current]);
		},
		playlistChange: function(index) {
			this.playlistConfig(index);
			$(this.cssSelector.jPlayer).jPlayer("play");
		},
		playlistNext: function() {
			var index = (this.current + 1 < this.playlist.length) ? this.current + 1 : 0;
			this.playlistChange(index);
		},
		playlistPrev: function() {
			var index = (this.current - 1 >= 0) ? this.current - 1 : this.playlist.length - 1;
			this.playlistChange(index);
		}
	};


	var audioPlaylist = new Playlist("2", [
		{
			name:data[0].track.name,
			mp3: data[0].track.mp3,
			oga: data[0].track.oga
		},
		{
			name:data[1].track.name,
			mp3: data[1].track.mp3,
			oga: data[1].track.oga
		}
	

	], {
		ready: function() {
			audioPlaylist.displayPlaylist();
			audioPlaylist.playlistInit(false); // Parameter is a boolean for autoplay.
		},
		ended: function() {
			audioPlaylist.playlistNext();
		},
		play: function() {
			$(this).jPlayer("pauseOthers");
		},
		swfPath: "js",
		supplied: "oga, mp3"
	});
		});


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
		
$("#subjects_search input").keyup(function(){
	$.get($("#subjects_search").attr("action"), $("#subjects_search").serialize(),null,"script");
	return false;
});

$("#subjects th a, #subjects .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$('h4.title').jTruncate({  
			length: 14,
			minTrail: 0,
			moreText: "", //[see all]
			lessText: "", //[hide extra]
			ellipsisText: "", // (truncated)
			moreAni: "", // fast
			lessAni: 2000
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


Cufon.replace('h1, h2, h3, h4:not(.nocufon), h5, h6, .heading_page, .search_text');

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

$("#bands th a, #bands .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#albums th a, #albums .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});



$("#tracks th a, #tracks .pagination a").live("click", function(){
 $.getScript(this.href);
 return false;
});

$("#bands_search input").keyup(function(){
	$.get($("#bands_search").attr("action"), $("#bands_search").serialize(),null,"script");
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


$("input.datum").datepicker({ dateFormat: 'yy-mm-dd' });	
			

			
			
			});
function initAnalytics(){
	var accountId = 'UA-2764682-5';
	jQuery.getScript('http://www.google-analytics.com/ga.js', function(){
		try {
			var pageTracker = _gat._getTracker(accountId);
			pageTracker._trackPageview();
		} catch(err) {}
	});
}

$(document).ready(function(){
	initAnalytics();
	$('#contact p a').attr('href', 'mailto:steve@stevenwilkin.com');
});

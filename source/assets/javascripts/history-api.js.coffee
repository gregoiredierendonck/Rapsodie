$(document).ready ->

  anchorClick = (link) ->
    linkSplit = link.split('/').pop()
    $.get 'pages/' + linkSplit, (data) ->
      $('#content').html data
      return
    return

  $('#container').on 'click', 'a', (e) ->
    window.history.pushState null, null, $(this).attr('href')
    anchorClick $(this).attr('href')
    e.preventDefault()
    return
  window.addEventListener 'popstate', (e) ->
    anchorClick location.pathname
    return
  return

# $(document).ready(function() {

# 	function anchorClick(link) {
# 		var linkSplit = link.split('/').pop();
# 		$.get('pages/' + linkSplit, function(data) {
# 			$('#content').html(data);
# 		});
# 	}

# 	$('#container').on('click', 'a', function(e) {
# 		window.history.pushState(null, null, $(this).attr('href'));
# 		anchorClick($(this).attr('href'));
# 		e.preventDefault();
# 	});

# 	window.addEventListener('popstate', function(e) {
# 		anchorClick(location.pathname);
# 	});

# });

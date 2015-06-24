$(document).ready ->

	anchorClick = (link) ->
		linkSplit = link.split('/').pop()
		$.get 'pages/' + linkSplit, (data) ->
			$('#content').html data

	$('#container').on 'click', '.changepage', (e) ->
		e.preventDefault()
		window.history.pushState null, null, $(this).attr('href')
		anchorClick $(this).attr('href')

	window.addEventListener 'popstate', (e) ->
		anchorClick location.pathname

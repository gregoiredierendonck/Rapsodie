$(document).ready ->

	anchorClick = (link) ->
		linkSplit = link.split('/').pop()
		$.get 'pages/' + linkSplit, (data) ->
			$('#content').html data
			$('.magnific-video-link').magnificPopup type: 'iframe'
			$('.magnific-image-link').magnificPopup type: 'image'

	$('#container').on 'click', '.changepage', (e) ->
		e.preventDefault()
		window.history.pushState null, null, $(this).attr('href')
		anchorClick $(this).attr('href')

	window.addEventListener 'popstate', (e) ->
		anchorClick location.pathname

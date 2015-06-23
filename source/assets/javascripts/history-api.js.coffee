$(document).ready ->

	body = $('html, body')
	anchorClick = (link) ->
		linkSplit = link.split('/').pop()
		$.get 'pages/' + linkSplit, (data) ->
			$('#content').html data
			return
		return

	# Scroll on top when change page
	$(body).scrollTop 0
	# Special function for lightbox
	# $('.magnific-image-link').magnificPopup type: 'image'
 	# $('.magnific-video-link').magnificPopup type: 'iframe'

	$('#container').on 'click', '.changepage', (e) ->
		window.history.pushState null, null, $(this).attr('href')
		anchorClick $(this).attr('href')
		e.preventDefault()
		return
	window.addEventListener 'popstate', (e) ->
		anchorClick location.pathname
		return
	return

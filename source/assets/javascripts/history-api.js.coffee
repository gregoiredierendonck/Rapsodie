# RemoveImage = ->
# 	if window.matchMedia('(max-width: 768px)').matches
# 		$(".element-remove").remove();

$(document).ready ->
	# RemoveImage()

	anchorClick = (link) ->
		linkSplit = link.split('/').pop()
		$.get 'pages/' + linkSplit, (data) ->
			$('#content').html data
			$('.magnific-video-link').magnificPopup type: 'iframe'
			$('.magnific-image-link').magnificPopup type: 'image'
			RemoveImage()

	$('#container').on 'click', '.changepage', (e) ->
		e.preventDefault()
		window.history.pushState null, null, $(this).attr('href')
		anchorClick $(this).attr('href')

	window.addEventListener 'popstate', (e) ->
		anchorClick location.pathname

# $(window).smartresize ->
# 	RemoveImage()

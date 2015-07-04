# Init headroom - menu appear only on scroll top when not on top
launchHeadroom = ->
	header = document.querySelector('#header')
	headroom = new Headroom(header,
		offset: 300
		tolerance: 10
		classes:
			initial: 'animated'
			pinned: 'headroom--pinned'
			unpinned: 'headroom--unpinned'
	)
	headroom.init()

# Detect if the menu have to go small or large version
DetectMenuVersion = ->
	contenerWidth = $('#header-menu').width()
	menuWidth = $('#header-menu-list').width() + 30
	if menuWidth > contenerWidth
		$('#header').removeClass 'large'
		$('#header').addClass 'small'
	else
		$('#header').removeClass 'small'
		$('#header').addClass 'large'

# Show or hide nav on click on button
ToggleMenu = ->
	`var slideTo`
	posi = parseInt($('#header-menu').css('top'))
	if posi == 0
		$('#header-menu').css 'top': '-100vh'
		$('#header-menu').css 'opacity': '0'
		$('#header-menu-button').removeClass 'open'
		$('#header-menu-button').addClass 'close'
	else
		$('#header-menu').css 'top': '0'
		$('#header-menu').css 'opacity': '1'
		$('#header-menu-button').removeClass 'close'
		$('#header-menu-button').addClass 'open'

# Go to the top of the page on page change
GotoTop = ->
	$('html, body').scrollTop(0);

# Go to the top of the page on page change
ActiveMenu = ->
	$('#header-menu a').removeClass('is-active')

# Replace (window).resize() for something better on Chrome
# Debounce and SmartResize from John Hann (in jQuery) ported to CoffeeScript
(($, sr) ->
  debounce = (func, threshold, execAsap) ->
    timeout = undefined
    debounced = ->
      delayed = ->
        func.apply obj, args  unless execAsap
        timeout = null
        return
      obj = this
      args = arguments
      if timeout
        clearTimeout timeout
      else func.apply obj, args  if execAsap
      timeout = setTimeout(delayed, threshold or 100)
      return
  # Smartresize
  jQuery.fn[sr] = (fn) ->
    (if fn then @bind("resize", debounce(fn)) else @trigger(sr))
  return
) jQuery, "smartresize"

# Call function
$(document).ready ->
	launchHeadroom()
	DetectMenuVersion()

	$('#header-menu-button').click ->
		ToggleMenu()

	$('.changepage').click ->
		GotoTop()

	$('.small .menu-link.changepage').click ->
		ToggleMenu()

	$('#header-menu .changepage').click ->
		ActiveMenu()
		$(this).addClass('is-active')

$(window).smartresize ->
	DetectMenuVersion()

	$('#header-menu-button').click ->
		ToggleMenu()

	$('.changepage').click ->
		GotoTop()

	$('.small .menu-link.changepage').click ->
		ToggleMenu()

	$('#header-menu .changepage').click ->
		ActiveMenu()
		$(this).addClass('is-active')

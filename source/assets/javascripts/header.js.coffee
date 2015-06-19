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

DetectMenuVersion = ->
  headerWidth = $('#header-contener').width()
  logoWidth = $('#header-logo').width()
  menuWidth = $('#header-menu').width() + 50
  if logoWidth + menuWidth >= headerWidth
    $('#header').removeClass 'large'
    $('#header').addClass 'small'
  else
    $('#header').removeClass 'small'
    $('#header').addClass 'large'
  return

ButtonClick = ->
  $('#header-menu-button').click ->
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
  return

$(document).ready ->

  launchHeadroom()
  DetectMenuVersion()
  ButtonClick()
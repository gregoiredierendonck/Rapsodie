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

$ ->
  launchHeadroom()
// Function to load and initiate the Analytics tracker
function gaTracker(id){
  $.getScript('//www.google-analytics.com/analytics.js'); // jQuery shortcut
  window.ga=window.ga||function(){(ga.q=ga.q||[]).push(arguments)};ga.l=+new Date;
  ga('create', id, 'auto');
  ga('send', 'pageview');
}

// Function to track a virtual page view
function gaTrack(path, title) {
  ga('set', { page: path, title: title });
  ga('send', 'pageview');
}

// Initiate the tracker after app has loaded
gaTracker('UA-69304119-1');

// Track a virtual page
gaTrack('/', 'Accueil');
gaTrack('/index.html', 'Accueil');
gaTrack('/legroupe.html', 'Le groupe');
gaTrack('/concerts.html', 'Concerts');
gaTrack('/albums.html', 'Albums');
gaTrack('/ateliers.html', 'Ateliers');
gaTrack('/presse.html', 'Presse');
gaTrack('/contact.html', 'Contact');
gaTrack('/404.html', '404');

// Event tracking on "contact button" click
$('#contactbutton').click(function() {
  ga('send', {
    hitType: 'event',
    eventCategory: 'Contact',
    eventAction: 'click',
    eventLabel: 'contact button click'
  });
});

// Event tracking on "buy Fugue album" button click
$('#fugue-button').click(function() {
  ga('send', {
    hitType: 'event',
    eventCategory: 'Achat',
    eventAction: 'click',
    eventLabel: 'buy fugue'
  });
});

// Event tracking on "buy Prelude album" button click
$('#prelude-button').click(function() {
  ga('send', {
    hitType: 'event',
    eventCategory: 'Achat',
    eventAction: 'click',
    eventLabel: 'buy prelude'
  });
});

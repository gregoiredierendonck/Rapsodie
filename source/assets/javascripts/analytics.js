// Hotjar UX tracking
(function(h,o,t,j,a,r){
  h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
  h._hjSettings={hjid:122671,hjsv:5};
  a=o.getElementsByTagName('head')[0];
  r=o.createElement('script');r.async=1;
  r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
  a.appendChild(r);
})(window,document,'//static.hotjar.com/c/hotjar-','.js?sv=');


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
    eventAction: 'contact button click',
    eventLabel: 'contact button click'
  });
});

// Event tracking on "buy Fugue album" button click
$('#fugue-button').click(function() {
  ga('send', {
    hitType: 'event',
    eventCategory: 'Achat',
    eventAction: 'buy fugue',
    eventLabel: 'buy fugue'
  });
});

// Event tracking on "buy Prelude album" button click
$('#prelude-button').click(function() {
  ga('send', {
    hitType: 'event',
    eventCategory: 'Achat',
    eventAction: 'buy prelude',
    eventLabel: 'buy prelude'
  });
});

// Event tracking for "visit YouTube" page
$('#youtube-button').click(function() {
  ga('send', {
    hitType: 'event',
    eventCategory: 'Social',
    eventAction: 'YouTube',
    eventLabel: 'YouTube'
  });
});

// Event tracking for "visit Facebook" page
$('#facebook-button').click(function() {
  ga('send', {
    hitType: 'event',
    eventCategory: 'Social',
    eventAction: 'Facebook',
    eventLabel: 'Facebook'
  });
});

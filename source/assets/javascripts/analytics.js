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

// Track an event on contact button click
$('#contactbutton').click({
  ga('send', 'event', 'Contact', 'click', 'contact button click');
});

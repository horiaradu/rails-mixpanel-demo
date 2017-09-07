document.addEventListener("turbolinks:load", function () {
  if (typeof mixpanel === 'undefined') return;

  mixpanel.track('Page Loaded');
});

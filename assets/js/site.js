(function () {
  var root = document.documentElement;
  var themeButton = document.querySelector('.theme-toggle');
  var navButton = document.querySelector('.nav-toggle');
  var nav = document.querySelector('.site-nav');

  function themeLabel() {
    if (!themeButton) return;
    themeButton.setAttribute('aria-label', root.dataset.theme === 'dark' ? 'Switch to light theme' : 'Switch to dark theme');
  }

  if (themeButton) {
    themeLabel();
    themeButton.addEventListener('click', function () {
      var next = root.dataset.theme === 'dark' ? 'light' : 'dark';
      root.dataset.theme = next;
      localStorage.setItem('mg-theme', next);
      themeLabel();
    });
  }

  if (navButton && nav) {
    navButton.addEventListener('click', function () {
      var open = nav.getAttribute('data-open') === 'true';
      nav.setAttribute('data-open', String(!open));
      navButton.setAttribute('aria-expanded', String(!open));
    });

    nav.addEventListener('click', function (event) {
      if (event.target.tagName === 'A') {
        nav.removeAttribute('data-open');
        navButton.setAttribute('aria-expanded', 'false');
      }
    });
  }
}());

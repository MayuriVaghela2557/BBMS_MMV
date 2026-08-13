/* ==========================================================================
   LIFELINE BLOOD BANK — MAIN.JS
   UI interactions only. No backend / persistence logic (Phase 1 frontend).
   ========================================================================== */

document.addEventListener('DOMContentLoaded', function () {

  /* ------------------------------------------------------------------------
     1. STICKY HEADER SHADOW ON SCROLL
     ------------------------------------------------------------------------ */
  var siteHeader = document.querySelector('.site-header');
  if (siteHeader) {
    var handleHeaderScroll = function () {
      if (window.scrollY > 12) {
        siteHeader.classList.add('is-scrolled');
      } else {
        siteHeader.classList.remove('is-scrolled');
      }
    };
    window.addEventListener('scroll', handleHeaderScroll);
    handleHeaderScroll();
  }

  /* ------------------------------------------------------------------------
     2. MOBILE HAMBURGER MENU
     ------------------------------------------------------------------------ */
  var hamburger = document.querySelector('.hamburger');
  var navMenu = document.querySelector('.nav-menu');
  var navCta = document.querySelector('.nav-cta');

  if (hamburger && navMenu) {
    hamburger.addEventListener('click', function () {
      hamburger.classList.toggle('is-active');
      navMenu.classList.toggle('is-open');
      if (navCta) { navCta.classList.toggle('is-open'); }
    });

    // Close mobile menu when a nav link is clicked
    navMenu.querySelectorAll('a').forEach(function (link) {
      link.addEventListener('click', function () {
        hamburger.classList.remove('is-active');
        navMenu.classList.remove('is-open');
        if (navCta) { navCta.classList.remove('is-open'); }
      });
    });
  }

  /* ------------------------------------------------------------------------
     3. ACTIVE NAVIGATION HIGHLIGHT
     (also set server-side via .active class per page; this is a safety net
     for pages sharing the same file name pattern)
     ------------------------------------------------------------------------ */
  var currentPage = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-menu a').forEach(function (link) {
    var href = link.getAttribute('href');
    if (href === currentPage) {
      link.classList.add('active');
    }
  });

  /* ------------------------------------------------------------------------
     4. BACK TO TOP BUTTON
     ------------------------------------------------------------------------ */
  var backToTop = document.querySelector('.back-to-top');
  if (backToTop) {
    window.addEventListener('scroll', function () {
      if (window.scrollY > 420) {
        backToTop.classList.add('is-visible');
      } else {
        backToTop.classList.remove('is-visible');
      }
    });
    backToTop.addEventListener('click', function () {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  /* ------------------------------------------------------------------------
     5. COUNTER ANIMATION (statistics section)
     ------------------------------------------------------------------------ */
  var counters = document.querySelectorAll('[data-counter]');
  if (counters.length) {
    var animateCounter = function (el) {
      var target = parseInt(el.getAttribute('data-counter'), 10) || 0;
      var duration = 1600;
      var startTime = null;

      var step = function (timestamp) {
        if (!startTime) { startTime = timestamp; }
        var progress = Math.min((timestamp - startTime) / duration, 1);
        var eased = 1 - Math.pow(1 - progress, 3); // ease-out cubic
        var current = Math.floor(eased * target);
        el.textContent = current.toLocaleString();
        if (progress < 1) {
          window.requestAnimationFrame(step);
        } else {
          el.textContent = target.toLocaleString();
        }
      };
      window.requestAnimationFrame(step);
    };

    var counterObserver = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting && !entry.target.dataset.counted) {
          entry.target.dataset.counted = 'true';
          animateCounter(entry.target);
        }
      });
    }, { threshold: 0.4 });

    counters.forEach(function (counter) { counterObserver.observe(counter); });
  }

  /* ------------------------------------------------------------------------
     6. FAQ ACCORDION
     ------------------------------------------------------------------------ */
  var faqItems = document.querySelectorAll('.faq-item');
  faqItems.forEach(function (item) {
    var question = item.querySelector('.faq-question');
    var answer = item.querySelector('.faq-answer');
    if (!question || !answer) { return; }

    question.addEventListener('click', function () {
      var isOpen = item.classList.contains('is-open');

      // Close all other items (single-open accordion)
      faqItems.forEach(function (other) {
        other.classList.remove('is-open');
        other.querySelector('.faq-answer').style.maxHeight = null;
      });

      if (!isOpen) {
        item.classList.add('is-open');
        answer.style.maxHeight = answer.scrollHeight + 'px';
      }
    });
  });

  /* ------------------------------------------------------------------------
     7. TESTIMONIAL SLIDER
     ------------------------------------------------------------------------ */
  var testiSlides = document.querySelectorAll('.testi-slide');
  var testiDotsWrap = document.querySelector('.testi-dots');
  if (testiSlides.length) {
    var currentSlide = 0;
    var slideInterval;

    var showSlide = function (index) {
      testiSlides.forEach(function (slide, i) {
        slide.classList.toggle('is-active', i === index);
      });
      if (testiDotsWrap) {
        testiDotsWrap.querySelectorAll('button').forEach(function (dot, i) {
          dot.classList.toggle('is-active', i === index);
        });
      }
      currentSlide = index;
    };

    var nextSlide = function () {
      showSlide((currentSlide + 1) % testiSlides.length);
    };

    if (testiDotsWrap) {
      testiSlides.forEach(function (_, i) {
        var dot = document.createElement('button');
        if (i === 0) { dot.classList.add('is-active'); }
        dot.setAttribute('aria-label', 'Show testimonial ' + (i + 1));
        dot.addEventListener('click', function () {
          showSlide(i);
          resetInterval();
        });
        testiDotsWrap.appendChild(dot);
      });
    }

    var resetInterval = function () {
      clearInterval(slideInterval);
      slideInterval = setInterval(nextSlide, 6000);
    };

    showSlide(0);
    resetInterval();
  }

  /* ------------------------------------------------------------------------
     8. GALLERY FILTER + LIGHTBOX
     ------------------------------------------------------------------------ */
  var filterButtons = document.querySelectorAll('.filter-tabs button');
  var galleryItems = document.querySelectorAll('.gallery-item');

  filterButtons.forEach(function (btn) {
    btn.addEventListener('click', function () {
      filterButtons.forEach(function (b) { b.classList.remove('is-active'); });
      btn.classList.add('is-active');
      var filter = btn.getAttribute('data-filter');

      galleryItems.forEach(function (item) {
        var category = item.getAttribute('data-category');
        var show = (filter === 'all' || filter === category);
        item.style.display = show ? 'flex' : 'none';
      });
    });
  });

  var lightbox = document.querySelector('.lightbox-overlay');
  if (lightbox) {
    var lightboxCaption = lightbox.querySelector('.lightbox-caption-text');
    var lightboxImg = lightbox.querySelector('.lightbox-media img');

    galleryItems.forEach(function (item) {
      item.addEventListener('click', function () {
        var caption = item.getAttribute('data-caption') || 'Gallery image';
        var photo = item.getAttribute('data-photo');
        if (lightboxCaption) { lightboxCaption.textContent = caption; }
        if (lightboxImg && photo) { lightboxImg.src = photo; lightboxImg.alt = caption; }
        lightbox.classList.add('is-open');
      });
    });

    var closeLightbox = function () { lightbox.classList.remove('is-open'); };
    var closeBtn = lightbox.querySelector('.lightbox-close');
    if (closeBtn) { closeBtn.addEventListener('click', closeLightbox); }
    lightbox.addEventListener('click', function (e) {
      if (e.target === lightbox) { closeLightbox(); }
    });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') { closeLightbox(); }
    });
  }

  /* ------------------------------------------------------------------------
     9. BLOOD AVAILABILITY — SEARCH / FILTER TABLE
     ------------------------------------------------------------------------ */
  var availSearchInput = document.querySelector('#availSearchInput');
  var availGroupSelect = document.querySelector('#availGroupSelect');
  var availRows = document.querySelectorAll('.avail-table tbody tr');

  var filterAvailTable = function () {
    var term = availSearchInput ? availSearchInput.value.trim().toLowerCase() : '';
    var group = availGroupSelect ? availGroupSelect.value : 'all';

    availRows.forEach(function (row) {
      var hospital = (row.getAttribute('data-hospital') || '').toLowerCase();
      var city = (row.getAttribute('data-city') || '').toLowerCase();
      var rowGroup = row.getAttribute('data-group') || '';

      var matchesTerm = !term || hospital.indexOf(term) !== -1 || city.indexOf(term) !== -1;
      var matchesGroup = (group === 'all' || group === rowGroup);

      row.style.display = (matchesTerm && matchesGroup) ? '' : 'none';
    });
  };

  if (availSearchInput) { availSearchInput.addEventListener('input', filterAvailTable); }
  if (availGroupSelect) { availGroupSelect.addEventListener('change', filterAvailTable); }

  // Blood group quick-filter cards on availability page
  document.querySelectorAll('[data-group-filter]').forEach(function (card) {
    card.addEventListener('click', function () {
      var group = card.getAttribute('data-group-filter');
      if (availGroupSelect) {
        availGroupSelect.value = group;
        filterAvailTable();
        var tableWrap = document.querySelector('.avail-table-wrap');
        if (tableWrap) { tableWrap.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
      }
    });
  });

  /* ------------------------------------------------------------------------
     10. EMERGENCY LEVEL SELECTOR VISUAL STATE (Request Blood form)
     ------------------------------------------------------------------------ */
  var emergencyInputs = document.querySelectorAll('.emergency-scale input');
  emergencyInputs.forEach(function (input) {
    input.addEventListener('change', function () {
      document.querySelectorAll('.emergency-scale label').forEach(function (label) {
        label.style.background = '';
        label.style.color = '';
        label.style.borderColor = '';
      });
    });
  });

  /* ------------------------------------------------------------------------
     11. FRONTEND-ONLY FORM SUBMIT FEEDBACK
     (No backend yet — Phase 1. Prevent default and show a friendly note.)
     ------------------------------------------------------------------------ */
  document.querySelectorAll('form[data-frontend-only]').forEach(function (form) {
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      var noteId = form.getAttribute('data-frontend-only');
      var note = noteId ? document.querySelector(noteId) : null;
      if (note) {
        note.classList.add('is-visible');
        note.scrollIntoView({ behavior: 'smooth', block: 'center' });
      } else {
        alert('This is a frontend-only demo. Form submission will be connected once the backend is built.');
      }
    });
  });

  /* ------------------------------------------------------------------------
     12. SMOOTH SCROLL FOR ON-PAGE ANCHOR LINKS
     ------------------------------------------------------------------------ */
  document.querySelectorAll('a[href^="#"]:not([href="#"])').forEach(function (anchor) {
    anchor.addEventListener('click', function (e) {
      var targetEl = document.querySelector(anchor.getAttribute('href'));
      if (targetEl) {
        e.preventDefault();
        targetEl.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

});

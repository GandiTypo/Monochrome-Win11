// volume-slider.js – Menambahkan slider volume kustom di sebelah tombol volume Spotify
(function() {
  'use strict';

  // Tunggu hingga DOM siap dan Spicetify Player tersedia
  function init() {
    const container = document.querySelector('.main-nowPlayingBar-extraControls');
    if (!container) {
      // Jika container belum ada, coba lagi setelah beberapa saat
      setTimeout(init, 500);
      return;
    }

    // Cegah duplikasi
    if (container.querySelector('.custom-volume-slider')) return;

    // Buat input range
    const slider = document.createElement('input');
    slider.type = 'range';
    slider.className = 'custom-volume-slider';
    slider.min = 0;
    slider.max = 1;
    slider.step = 0.01;

    // Set nilai awal sesuai volume saat ini
    try {
      const currentVolume = Spicetify.Player.getVolume();
      slider.value = currentVolume;
    } catch (e) {
      slider.value = 0.5; // fallback
    }

    // Event listener untuk mengubah volume
    slider.addEventListener('input', function(e) {
      const vol = parseFloat(e.target.value);
      Spicetify.Player.setVolume(vol);
    });

    // Sisipkan slider di sebelah tombol volume (biasanya tombol volume ada di dalam container)
    // Kita tambahkan sebagai anak pertama agar berada di sebelah kiri tombol volume
    container.prepend(slider);
  }

  // Mulai inisialisasi setelah Spicetify siap
  if (window.Spicetify && Spicetify.Player) {
    init();
  } else {
    document.addEventListener('spicetify-ready', init);
  }
})();
const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-imbibe');

  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        navbar.classList.add('navbar-imbibe-white');

      } else {
        navbar.classList.remove('navbar-imbibe-white');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };

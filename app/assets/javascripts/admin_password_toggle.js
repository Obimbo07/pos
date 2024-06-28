document.addEventListener('DOMContentLoaded', function() {
    const togglePasswordIcons = document.querySelectorAll('.toggle-password');
  
    togglePasswordIcons.forEach(function(icon) {
      icon.addEventListener('click', function() {
        const input = document.querySelector(`#${this.dataset.input}`);
        if (input.type === 'password') {
          input.type = 'text';
          this.classList.remove('fa-eye');
          this.classList.add('fa-eye-slash');
        } else {
          input.type = 'password';
          this.classList.remove('fa-eye-slash');
          this.classList.add('fa-eye');
        }
      });
    });
  });
  
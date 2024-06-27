document.addEventListener('DOMContentLoaded', function() {
  const togglePassword = document.getElementById('toggle-password');
  const passwordField = document.getElementById('password');
  const togglePasswordConfirmation = document.getElementById('toggle-password-confirmation');
  const passwordConfirmationField = document.getElementById('password-confirmation');

  if (togglePassword && passwordField) {
    togglePassword.addEventListener('click', function() {
      const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordField.setAttribute('type', type);
      this.querySelector('i').classList.toggle('fa-eye');
      this.querySelector('i').classList.toggle('fa-eye-slash');
    });
  }

  if (togglePasswordConfirmation && passwordConfirmationField) {
    togglePasswordConfirmation.addEventListener('click', function() {
      const type = passwordConfirmationField.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordConfirmationField.setAttribute('type', type);
      this.querySelector('i').classList.toggle('fa-eye');
      this.querySelector('i').classList.toggle('fa-eye-slash');
    });
  }
});

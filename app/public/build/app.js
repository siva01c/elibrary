// Main JavaScript file - Modern ES6+ syntax
class ELibraryApp {
    constructor() {
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.initializeComponents();
    }

    setupEventListeners() {
        // DOM loaded
        document.addEventListener('DOMContentLoaded', () => {
            this.initializeAlerts();
            this.initializeDeleteConfirmation();
            this.initializeFormValidation();
        });
    }

    initializeComponents() {
        // Initialize flash messages
        this.initializeAlerts();
    }

    // Alert/Flash message handling
    initializeAlerts() {
        const alerts = document.querySelectorAll('.alert-dismissible');
        
        alerts.forEach(alert => {
            const closeBtn = alert.querySelector('.btn-close');
            if (closeBtn) {
                closeBtn.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.dismissAlert(alert);
                });
            }

            // Auto-dismiss after 5 seconds
            setTimeout(() => {
                if (alert.parentNode) {
                    this.dismissAlert(alert);
                }
            }, 5000);
        });
    }

    dismissAlert(alert) {
        alert.classList.remove('show');
        alert.classList.add('fade');
        
        setTimeout(() => {
            if (alert.parentNode) {
                alert.remove();
            }
        }, 150);
    }

    // Delete confirmation handling
    initializeDeleteConfirmation() {
        // Book deletion
        window.deleteBook = (bookId, bookTitle) => {
            const confirmed = confirm(`Are you sure you want to delete "${bookTitle}"? This action cannot be undone.`);
            
            if (confirmed) {
                this.submitDeleteForm(bookId, 'book');
            }
        };
    }

    submitDeleteForm(itemId, itemType) {
        // Create form dynamically
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `/${itemType}/${itemId}/delete`;
        form.style.display = 'none';

        // Add CSRF token
        const csrfToken = document.querySelector('meta[name="csrf-token"]');
        if (csrfToken) {
            const tokenInput = document.createElement('input');
            tokenInput.type = 'hidden';
            tokenInput.name = '_token';
            tokenInput.value = csrfToken.getAttribute('content');
            form.appendChild(tokenInput);
        }

        // Add to body and submit
        document.body.appendChild(form);
        form.submit();
    }

    // Form validation
    initializeFormValidation() {
        const forms = document.querySelectorAll('form');
        
        forms.forEach(form => {
            form.addEventListener('submit', (e) => {
                if (!this.validateForm(form)) {
                    e.preventDefault();
                }
            });

            // Real-time validation
            const inputs = form.querySelectorAll('input, textarea, select');
            inputs.forEach(input => {
                input.addEventListener('blur', () => {
                    this.validateField(input);
                });
            });
        });
    }

    validateForm(form) {
        let isValid = true;
        const inputs = form.querySelectorAll('input[required], textarea[required], select[required]');
        
        inputs.forEach(input => {
            if (!this.validateField(input)) {
                isValid = false;
            }
        });

        return isValid;
    }

    validateField(field) {
        const value = field.value.trim();
        let isValid = true;
        let errorMessage = '';

        // Required field validation
        if (field.hasAttribute('required') && !value) {
            isValid = false;
            errorMessage = 'This field is required.';
        }

        // Email validation
        if (field.type === 'email' && value) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(value)) {
                isValid = false;
                errorMessage = 'Please enter a valid email address.';
            }
        }

        // Number validation
        if (field.type === 'number' && value) {
            if (isNaN(value)) {
                isValid = false;
                errorMessage = 'Please enter a valid number.';
            }
        }

        // Update field appearance
        this.updateFieldValidation(field, isValid, errorMessage);
        
        return isValid;
    }

    updateFieldValidation(field, isValid, errorMessage) {
        // Remove existing validation classes
        field.classList.remove('is-valid', 'is-invalid');
        
        // Remove existing error message
        const existingError = field.parentNode.querySelector('.invalid-feedback');
        if (existingError) {
            existingError.remove();
        }

        if (!isValid) {
            field.classList.add('is-invalid');
            
            // Add error message
            const errorDiv = document.createElement('div');
            errorDiv.className = 'invalid-feedback';
            errorDiv.textContent = errorMessage;
            field.parentNode.appendChild(errorDiv);
        } else if (field.value.trim()) {
            field.classList.add('is-valid');
        }
    }

    // Utility methods
    static showLoading(button) {
        const originalText = button.textContent;
        button.textContent = 'Loading...';
        button.disabled = true;
        button.dataset.originalText = originalText;
    }

    static hideLoading(button) {
        const originalText = button.dataset.originalText;
        if (originalText) {
            button.textContent = originalText;
            button.disabled = false;
            delete button.dataset.originalText;
        }
    }

    // Print functionality
    static printPage() {
        window.print();
    }

    // Smooth scroll to top
    static scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }
}

// Initialize the application
const app = new ELibraryApp();

// Export for global access if needed
window.ELibraryApp = ELibraryApp;

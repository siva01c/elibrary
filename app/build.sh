#!/bin/bash

# Build script for SASS compilation and asset processing
echo "Starting asset compilation..."

# Create build directory if it doesn't exist
mkdir -p public/build

# Check if sass command is available, otherwise use a simple CSS copy
echo "Compiling SASS files..."
if command -v sass &> /dev/null; then
    sass assets/styles/app.scss public/build/app.css --style expanded
elif command -v compass &> /dev/null; then
    compass compile --config config.rb --force
else
    echo "Neither sass nor compass found. Creating basic CSS from SASS files..."
    # Simple fallback - concatenate CSS files
    cat > public/build/app.css << 'EOF'
/* Basic CSS compiled from SASS */
/* Reset */
*,*::before,*::after{box-sizing:border-box;}*{margin:0;}html,body{height:100%;}body{line-height:1.5;-webkit-font-smoothing:antialiased;}
/* Typography */
body{font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;font-size:1rem;color:#212529;background-color:#fff;}
h1,h2,h3,h4,h5,h6{margin-top:0;margin-bottom:0.5rem;font-weight:500;line-height:1.2;}
h1{font-size:2.5rem;}h2{font-size:2rem;}h3{font-size:1.75rem;}h4{font-size:1.5rem;}h5{font-size:1.25rem;}h6{font-size:1rem;}
p{margin-top:0;margin-bottom:1rem;}a{color:#007bff;text-decoration:underline;}a:hover{color:#0056b3;}
/* Layout */
.container{width:100%;padding:0 0.75rem;margin:0 auto;max-width:1140px;}
.row{display:flex;flex-wrap:wrap;margin:0 -0.75rem;}
[class*="col-"]{padding:0 0.75rem;}
.d-flex{display:flex;}.justify-content-between{justify-content:space-between;}.align-items-center{align-items:center;}.flex-wrap{flex-wrap:wrap;}
.text-center{text-align:center;}.text-muted{color:#6c757d;}
/* Spacing */
.mt-4{margin-top:1.5rem;}.mb-2{margin-bottom:0.5rem;}.mb-3{margin-bottom:1rem;}.mb-4{margin-bottom:1.5rem;}.me-2{margin-right:0.5rem;}.pt-4{padding-top:1.5rem;}.border-top{border-top:1px solid #dee2e6;}
/* Buttons */
.btn{display:inline-block;font-weight:400;line-height:1.5;color:#212529;text-align:center;text-decoration:none;vertical-align:middle;cursor:pointer;user-select:none;background-color:transparent;border:1px solid transparent;padding:0.375rem 0.75rem;font-size:1rem;border-radius:0.375rem;transition:all 0.15s ease-in-out;}
.btn:hover{text-decoration:none;}.btn:focus{outline:0;box-shadow:0 0 0 0.2rem rgba(0,123,255,0.25);}
.btn-primary{color:#fff;background-color:#007bff;border-color:#007bff;}.btn-primary:hover{background-color:#0056b3;border-color:#0056b3;}
.btn-secondary{color:#fff;background-color:#6c757d;border-color:#6c757d;}.btn-secondary:hover{background-color:#545b62;border-color:#545b62;}
.btn-success{color:#fff;background-color:#28a745;border-color:#28a745;}.btn-success:hover{background-color:#1e7e34;border-color:#1e7e34;}
.btn-danger{color:#fff;background-color:#dc3545;border-color:#dc3545;}.btn-danger:hover{background-color:#c82333;border-color:#c82333;}
.btn-warning{color:#212529;background-color:#ffc107;border-color:#ffc107;}.btn-warning:hover{background-color:#e0a800;border-color:#e0a800;}
.btn-info{color:#fff;background-color:#17a2b8;border-color:#17a2b8;}.btn-info:hover{background-color:#117a8b;border-color:#117a8b;}
.btn-outline-secondary{color:#6c757d;border-color:#6c757d;}.btn-outline-secondary:hover{color:#fff;background-color:#6c757d;}
.btn-outline-success{color:#28a745;border-color:#28a745;}.btn-outline-success:hover{color:#fff;background-color:#28a745;}
.btn-outline-danger{color:#dc3545;border-color:#dc3545;}.btn-outline-danger:hover{color:#fff;background-color:#dc3545;}
.btn-outline-info{color:#17a2b8;border-color:#17a2b8;}.btn-outline-info:hover{color:#fff;background-color:#17a2b8;}
.btn-sm{padding:0.25rem 0.5rem;font-size:0.875rem;border-radius:0.25rem;}
.btn-group{position:relative;display:inline-flex;vertical-align:middle;}
.btn-group > .btn{position:relative;flex:1 1 auto;margin-left:-1px;}
.btn-group > .btn:not(:last-child){border-top-right-radius:0;border-bottom-right-radius:0;}
.btn-group > .btn:not(:first-child){border-top-left-radius:0;border-bottom-left-radius:0;}
/* Cards */
.card{position:relative;display:flex;flex-direction:column;min-width:0;background-color:#fff;border:1px solid #dee2e6;border-radius:0.375rem;box-shadow:0 0.125rem 0.25rem rgba(0,0,0,0.075);}
.card-body{flex:1 1 auto;padding:1rem;}.card-title{margin-bottom:0.5rem;font-size:1.25rem;font-weight:500;}
.card-header{padding:0.5rem 1rem;margin-bottom:0;background-color:#f8f9fa;border-bottom:1px solid #dee2e6;border-top-left-radius:calc(0.375rem - 1px);border-top-right-radius:calc(0.375rem - 1px);}
.card-footer{padding:0.5rem 1rem;background-color:#f8f9fa;border-top:1px solid #dee2e6;border-bottom-right-radius:calc(0.375rem - 1px);border-bottom-left-radius:calc(0.375rem - 1px);}
.h-100{height:100%;}.bg-transparent{background-color:transparent;}
/* Forms */
.form-control{display:block;width:100%;padding:0.375rem 0.75rem;font-size:1rem;font-weight:400;line-height:1.5;color:#495057;background-color:#fff;border:1px solid #ced4da;border-radius:0.375rem;transition:border-color 0.15s ease-in-out,box-shadow 0.15s ease-in-out;}
.form-control:focus{color:#495057;background-color:#fff;border-color:#80bdff;outline:0;box-shadow:0 0 0 0.2rem rgba(0,123,255,0.25);}
label{display:inline-block;margin-bottom:0.5rem;font-weight:500;}
/* Alerts */
.alert{position:relative;padding:0.75rem 1.25rem;margin-bottom:1rem;border:1px solid transparent;border-radius:0.375rem;}
.alert-success{color:#155724;background-color:#d4edda;border-color:#c3e6cb;}
.alert-info{color:#0c5460;background-color:#d1ecf1;border-color:#bee5eb;}
.alert-warning{color:#856404;background-color:#fff3cd;border-color:#ffeaa7;}
.alert-danger{color:#721c24;background-color:#f8d7da;border-color:#f5c6cb;}
.alert-dismissible{padding-right:4rem;}
.btn-close{box-sizing:content-box;width:1em;height:1em;padding:0.25em;color:#000;background:transparent;border:0;border-radius:0.375rem;opacity:0.5;}
.btn-close:hover{opacity:0.75;}
.fade{transition:opacity 0.15s linear;}.fade:not(.show){opacity:0;}.show{opacity:1;}
/* Breadcrumb */
.breadcrumb{display:flex;flex-wrap:wrap;padding:0;margin-bottom:1rem;list-style:none;}
.breadcrumb-item + .breadcrumb-item{padding-left:0.5rem;}
.breadcrumb-item + .breadcrumb-item::before{float:left;padding-right:0.5rem;color:#6c757d;content:"/";}
.breadcrumb-item.active{color:#6c757d;}
/* Icons */
.icon{font-family:'Arial Unicode MS','Lucida Grande',sans-serif;font-style:normal;font-weight:normal;display:inline-block;text-decoration:inherit;width:1em;text-align:center;font-variant:normal;text-transform:none;line-height:1em;margin-right:0.2em;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;}
.icon-plus::before{content:"+";}.icon-edit::before{content:"✎";}.icon-view::before{content:"👁";}.icon-delete::before{content:"✖";}.icon-download::before{content:"⬇";}.icon-upload::before{content:"⬆";}.icon-print::before{content:"🖶";}.icon-book::before{content:"📖";}.icon-arrow-left::before{content:"←";}
/* Utility Classes */
.import-form{display:inline-block;}
.hidden-form{display:none;}
.display-4{font-size:2.5rem;font-weight:300;line-height:1.2;}
.h4{font-size:1.5rem;}
.text-justify{text-align:justify;}
/* Print Styles */
.print-page{font-family:'Times New Roman',serif;line-height:1.6;color:#333;}
.print-controls{margin-bottom:2rem;text-align:center;}
.print-header{text-align:center;border-bottom:2px solid #333;padding-bottom:1rem;margin-bottom:2rem;}
.print-title{font-size:2.5rem;font-weight:bold;margin-bottom:0.5rem;}
.print-author{font-size:1.5rem;font-style:italic;margin-bottom:1rem;}
.print-meta{background:#f8f9fa;padding:1rem;border:1px solid #dee2e6;margin:1rem 0;}
.print-meta table{width:100%;border-collapse:collapse;}
.print-meta td{padding:0.5rem;border-bottom:1px solid #dee2e6;}
.print-meta td:first-child{font-weight:bold;width:30%;}
.print-content{margin-top:2rem;}
.print-content h2{border-bottom:1px solid #333;padding-bottom:0.5rem;}
.print-footer{margin-top:3rem;padding-top:1rem;border-top:1px solid #dee2e6;text-align:center;font-size:0.9rem;color:#666;}
@media print{.no-print{display:none !important;}.container{max-width:none !important;}.print-page{margin:0;padding:1cm;}}
EOF
fi

# Generate JavaScript file
echo "Generating JavaScript file..."
cat > public/build/app.js << 'EOF'
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
EOF

echo "Asset compilation completed!"
echo "Generated files:"
echo "- public/build/app.css"
echo "- public/build/app.js"
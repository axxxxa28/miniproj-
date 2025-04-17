document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.getElementById("login-form");

    loginForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;
        const role = document.getElementById("role").value;

        // In a real application, you would validate credentials against a server
        // For this demo, we'll just simulate a successful login

        // Store role in session storage for role-based access control
        sessionStorage.setItem("userRole", role);
        sessionStorage.setItem("username", username);

        // Redirect to dashboard
        window.location.href = "index.html";
    });
});
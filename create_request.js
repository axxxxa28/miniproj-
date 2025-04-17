/**
 * create_request.js
 * Handles request creation functionality
 */

document.addEventListener("DOMContentLoaded", function() {
    // Check if user is logged in
    const userRole = sessionStorage.getItem("userRole");

    if (!userRole) {
        // Redirect to login if not logged in
        window.location.href = "login.html";
        return;
    }

    // Handle form submission
    const requestForm = document.getElementById("request-form");

    requestForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const assetId = document.getElementById("asset-id").value;
        const departmentId = document.getElementById("department-id").value;
        const reason = document.getElementById("request-reason").value;

        // In a real application, this would send a request to the server
        // For this demo, we'll just show an alert and redirect

        // Create a new request object
        const request = {
            assetId: assetId,
            departmentId: departmentId,
            reason: reason,
            status: "Pending",
            date: new Date().toISOString().split('T')[0]
        };

        // In a real app, you would send this to your backend
        console.log("New request:", request);

        // Show success message
        alert("Request Submitted Successfully!");

        // Redirect back to home page
        window.location.href = "index.html";
    });
});
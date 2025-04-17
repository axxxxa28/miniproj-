/**
 * create_purchase_order.js
 * Handles purchase order creation functionality
 */

document.addEventListener("DOMContentLoaded", function() {
    // Check if user is logged in and is faculty
    const userRole = sessionStorage.getItem("userRole");

    if (!userRole) {
        // Redirect to login if not logged in
        window.location.href = "login.html";
        return;
    }

    if (userRole === "student") {
        // Students shouldn't access this page, redirect to home
        window.location.href = "index.html";
        return;
    }

    // Handle form submission
    const purchaseOrderForm = document.getElementById("purchase-order-form");

    purchaseOrderForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const supplierId = document.getElementById("supplier-id").value;
        const itemName = document.getElementById("item-name").value;
        const quantity = document.getElementById("quantity").value;
        const cost = document.getElementById("cost").value;

        // In a real application, this would send a request to the server
        // For this demo, we'll just show an alert and redirect

        // Create a new purchase order object
        const purchaseOrder = {
            supplierId: supplierId,
            itemName: itemName,
            quantity: quantity,
            cost: `$${parseFloat(cost).toFixed(2)}`,
            status: "Pending"
        };

        // In a real app, you would send this to your backend
        console.log("New purchase order:", purchaseOrder);

        // Show success message
        alert("Purchase Order Submitted Successfully!");

        // Redirect back to home page
        window.location.href = "index.html";
    });
});
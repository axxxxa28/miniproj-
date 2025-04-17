/**
 * approve_requests.js
 * Handles request approval functionality
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

    // Load pending requests
    const requests = [
        { id: 1, assetId: 'A101', departmentId: 'D01', status: 'Pending' },
        { id: 2, assetId: 'A102', departmentId: 'D02', status: 'Pending' },
        { id: 3, assetId: 'A103', departmentId: 'D01', status: 'Pending' }
    ];

    const tableBody = document.getElementById("approve-requests-table");

    requests.forEach(request => {
        const row = document.createElement("tr");

        // Create request information cells
        const idCell = document.createElement("td");
        idCell.textContent = request.id;

        const assetIdCell = document.createElement("td");
        assetIdCell.textContent = request.assetId;

        const departmentIdCell = document.createElement("td");
        departmentIdCell.textContent = request.departmentId;

        const statusCell = document.createElement("td");
        statusCell.innerHTML = `<span class="badge badge-pending">${request.status}</span>`;

        // Create approve button cell
        const approveCell = document.createElement("td");
        const approveButton = document.createElement("button");
        approveButton.className = "btn btn-primary";
        approveButton.innerHTML = '<i class="fas fa-check"></i> Yes';
        approveButton.addEventListener("click", function() {
            approveRequest(request.id);
        });
        approveCell.appendChild(approveButton);

        // Create reject button cell
        const rejectCell = document.createElement("td");
        const rejectButton = document.createElement("button");
        rejectButton.className = "btn btn-danger";
        rejectButton.innerHTML = '<i class="fas fa-times"></i> No';
        rejectButton.addEventListener("click", function() {
            rejectRequest(request.id);
        });
        rejectCell.appendChild(rejectButton);

        // Add all cells to the row
        row.appendChild(idCell);
        row.appendChild(assetIdCell);
        row.appendChild(departmentIdCell);
        row.appendChild(statusCell);
        row.appendChild(approveCell);
        row.appendChild(rejectCell);

        // Add the row to the table
        tableBody.appendChild(row);
    });
});

function approveRequest(requestId) {
    // In a real application, this would send a request to the server
    // For this demo, we'll just show an alert and update the UI
    alert(`Request ${requestId} approved!`);

    // Find and update the status badge
    updateRequestStatus(requestId, "Approved", "badge-available");
}

function rejectRequest(requestId) {
    // In a real application, this would send a request to the server
    // For this demo, we'll just show an alert and update the UI
    alert(`Request ${requestId} rejected!`);

    // Find and update the status badge
    updateRequestStatus(requestId, "Rejected", "badge-in-use");
}

function updateRequestStatus(requestId, status, badgeClass) {
    const tableRows = document.querySelectorAll("#approve-requests-table tr");

    tableRows.forEach(row => {
        const idCell = row.cells[0];
        if (idCell && idCell.textContent == requestId) {
            const statusCell = row.cells[3];
            statusCell.innerHTML = `<span class="badge ${badgeClass}">${status}</span>`;

            // Disable buttons
            const approveButton = row.cells[4].querySelector("button");
            const rejectButton = row.cells[5].querySelector("button");

            if (approveButton) approveButton.disabled = true;
            if (rejectButton) rejectButton.disabled = true;
        }
    });
}
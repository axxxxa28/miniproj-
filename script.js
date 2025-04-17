document.addEventListener("DOMContentLoaded", function() {
    // Check if user is logged in
    const userRole = sessionStorage.getItem("userRole");
    const username = sessionStorage.getItem("username");

    if (!userRole && window.location.pathname !== "/login.html") {
        // Redirect to login if not logged in
        window.location.href = "login.html";
        return;
    }

    // Set user greeting
    const userGreeting = document.getElementById("user-greeting");
    if (userGreeting) {
        userGreeting.textContent = `Welcome, ${username || 'User'}`;
    }

    // Mobile menu toggle
    const menuToggle = document.getElementById("menu-toggle");
    const navBar = document.getElementById("nav-bar");

    if (menuToggle && navBar) {
        menuToggle.addEventListener("click", function() {
            navBar.classList.toggle("active");
        });
    }

    // Logout functionality
    const logoutBtn = document.getElementById("logout-btn");
    if (logoutBtn) {
        logoutBtn.addEventListener("click", function(e) {
            e.preventDefault();
            sessionStorage.removeItem("userRole");
            sessionStorage.removeItem("username");
            window.location.href = "login.html";
        });
    }

    // Handle role-based display
    configureUIForRole(userRole);

    // Load dashboard data
    loadDashboardData();

    // Load tables
    loadAssetsTable();
    loadDepartmentsTable();
    loadRequestsTable();
    loadPurchaseOrdersTable();
    loadSuppliersTable();
    loadDeadstockTable();
    loadNotifications();
});

function configureUIForRole(userRole) {
    if (userRole === "student") {
        // Hide cost column
        const costHeader = document.getElementById("cost-header");
        if (costHeader) costHeader.style.display = "none";

        document.querySelectorAll("#assets-table td:nth-child(6)").forEach(cell => {
            if (cell) cell.style.display = "none";
        });

        // Hide sections not available for students
        const facultySections = [
            "purchase-orders", "suppliers", "deadstock", "requests"
        ];

        facultySections.forEach(section => {
            const sectionElement = document.getElementById(section);
            const navElement = document.getElementById(`${section}-nav`);

            if (sectionElement) sectionElement.style.display = "none";
            if (navElement) navElement.style.display = "none";
        });
    } else {
        // Hide student-only sections for faculty
        const studentSections = ["create-requests"];

        studentSections.forEach(section => {
            const sectionElement = document.getElementById(section);
            if (sectionElement) sectionElement.style.display = "none";
        });
    }
}

function loadDashboardData() {
    // In a real application, this would fetch data from an API
    // For this demo, we'll use static data
    document.getElementById("total-assets").innerText = "20";
    document.getElementById("total-departments").innerText = "5";
    document.getElementById("pending-requests").innerText = "3";
}

function loadAssetsTable() {
    const assetsData = [
        {
            id: "A001",
            name: "Projector",
            type: "Electronics",
            status: "Available",
            department: "CSE",
            cost: "$1,200",
            action: '<button class="btn btn-outline">View</button>'
        },
        {
            id: "A002",
            name: "Table",
            type: "Furniture",
            status: "In Use",
            department: "ECE",
            cost: "$300",
            action: '<button class="btn btn-outline">View</button>'
        },
        {
            id: "A003",
            name: "Laptop",
            type: "Electronics",
            status: "Available",
            department: "CSE",
            cost: "$900",
            action: '<button class="btn btn-outline">View</button>'
        },
        {
            id: "A004",
            name: "Whiteboard",
            type: "Office Supplies",
            status: "In Use",
            department: "MEC",
            cost: "$150",
            action: '<button class="btn btn-outline">View</button>'
        }
    ];

    populateTable("assets-table", assetsData);

    // Add status badges
    document.querySelectorAll("#assets-table tr").forEach(row => {
        const statusCell = row.cells[3];
        if (statusCell) {
            const status = statusCell.textContent;
            let badgeClass = "";

            if (status === "Available") {
                badgeClass = "badge-available";
            } else if (status === "In Use") {
                badgeClass = "badge-in-use";
            }

            statusCell.innerHTML = `<span class="badge ${badgeClass}">${status}</span>`;
        }
    });
}

function loadDepartmentsTable() {
    const departmentsData = [
        { id: "CSE", name: "Computer Science", location: "Block A", hod: "Dr. Smith" },
        { id: "ECE", name: "Electronics", location: "Block B", hod: "Dr. Johnson" },
        { id: "MEC", name: "Mechanical Engineering", location: "Block C", hod: "Dr. Williams" },
        { id: "CIV", name: "Civil Engineering", location: "Block D", hod: "Dr. Brown" },
        { id: "ELE", name: "Electrical Engineering", location: "Block B", hod: "Dr. Davis" }
    ];

    populateTable("departments-table", departmentsData);
}

function loadRequestsTable() {
    const requestsData = [
        { id: "R001", assetId: "A001", departmentId: "CSE", status: "Pending", date: "2025-03-20" },
        { id: "R002", assetId: "A003", departmentId: "ECE", status: "Approved", date: "2025-03-18" },
        { id: "R003", assetId: "A004", departmentId: "MEC", status: "Rejected", date: "2025-03-15" }
    ];

    populateTable("requests-table", requestsData);

    // Add status badges to requests
    document.querySelectorAll("#requests-table tr").forEach(row => {
        const statusCell = row.cells[3];
        if (statusCell) {
            const status = statusCell.textContent;
            let badgeClass = "";

            if (status === "Pending") {
                badgeClass = "badge-pending";
            } else if (status === "Approved") {
                badgeClass = "badge-available";
            } else if (status === "Rejected") {
                badgeClass = "badge-in-use";
            }

            statusCell.innerHTML = `<span class="badge ${badgeClass}">${status}</span>`;
        }
    });
}

function loadPurchaseOrdersTable() {
    const purchaseOrdersData = [
        { id: "PO001", supplier: "Tech Supplies Ltd", item: "Laptops", quantity: "5", cost: "$4,500", status: "Delivered" },
        { id: "PO002", supplier: "Office Furniture Co", item: "Chairs", quantity: "10", cost: "$1,000", status: "Pending" },
        { id: "PO003", supplier: "Electronics Wholesale", item: "Projectors", quantity: "2", cost: "$2,400", status: "Shipped" }
    ];

    populateTable("purchase-orders-table", purchaseOrdersData);
}

function loadSuppliersTable() {
    const suppliersData = [
        { id: "S001", name: "Tech Supplies Ltd", contact: "contact@techsupplies.com", address: "123 Tech St, City" },
        { id: "S002", name: "Office Furniture Co", contact: "sales@officefurniture.com", address: "456 Office Ave, City" },
        { id: "S003", name: "Electronics Wholesale", contact: "info@electronics.com", address: "789 Circuit Rd, City" }
    ];

    populateTable("suppliers-table", suppliersData);
}

function loadDeadstockTable() {
    const deadstockData = [
        { id: "A005", name: "Old Projector", reason: "Beyond repair", date: "2025-02-10" },
        { id: "A006", name: "Broken Chair", reason: "Damaged", date: "2025-01-15" }
    ];

    populateTable("deadstock-table", deadstockData);
}

function loadNotifications() {
    const notifications = [
        {
            title: "New Request",
            message: "Department CSE has requested Projector.",
            date: "2025-04-15",
            icon: "fas fa-clipboard-list"
        },
        {
            title: "Order Delivered",
            message: "Purchase order PO001 has been delivered.",
            date: "2025-04-14",
            icon: "fas fa-truck"
        },
        {
            title: "Asset Available",
            message: "Laptop (A003) is now available for use.",
            date: "2025-04-12",
            icon: "fas fa-laptop"
        }
    ];

    const notificationsList = document.getElementById("notifications-list");
    if (notificationsList) {
        notificationsList.innerHTML = "";

        notifications.forEach(notification => {
            const listItem = document.createElement("li");
            listItem.className = "notification-item";

            listItem.innerHTML = `
                <div class="notification-icon">
                    <i class="${notification.icon}"></i>
                </div>
                <div class="notification-content">
                    <h4>${notification.title}</h4>
                    <p>${notification.message}</p>
                    <span class="notification-date">${notification.date}</span>
                </div>
            `;

            notificationsList.appendChild(listItem);
        });
    }
}

function populateTable(tableId, data) {
    const table = document.getElementById(tableId);
    if (!table) return;

    table.innerHTML = "";

    data.forEach(item => {
        const row = document.createElement("tr");

        Object.values(item).forEach(value => {
            const cell = document.createElement("td");
            // Check if value contains HTML (like buttons)
            if (value && typeof value === 'string' && value.includes('<')) {
                cell.innerHTML = value;
            } else {
                cell.textContent = value;
            }
            row.appendChild(cell);
        });

        table.appendChild(row);
    });
}

function handleRequestButton() {
    window.location.href = 'approve_requests.html';
}

// Add event listeners for all table action buttons after DOM loads
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.btn').forEach(button => {
        button.addEventListener('click', function() {
            const action = this.textContent.trim();
            const row = this.closest('tr');
            const id = row ? row.cells[0].textContent : null;

            if (action === 'View' && id) {
                alert(`Viewing details for item ${id}`);
                // In a real application, this would open a modal or navigate to a detail page
            }
        });
    });
});